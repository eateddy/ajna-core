// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.14;

import {
    LENDER_MIN_BUCKET_INDEX,
    LENDER_MAX_BUCKET_INDEX,
    MIN_AMOUNT,
    MAX_AMOUNT
}                                          from './unbounded/BaseHandler.sol';
import { UnboundedLiquidationPoolHandler } from './unbounded/UnboundedLiquidationPoolHandler.sol';
import { BasicPoolHandler }                from './BasicPoolHandler.sol';

abstract contract LiquidationPoolHandler is UnboundedLiquidationPoolHandler, BasicPoolHandler {

    /*****************************/
    /*** Kicker Test Functions ***/
    /*****************************/

    function kickAuction(
        uint256 borrowerIndex_,
        uint256 amount_,
        uint256 kickerIndex_
    ) external useTimestamps {
        _kickAuction(borrowerIndex_, amount_, kickerIndex_);
    }

    function kickWithDeposit(
        uint256 kickerIndex_,
        uint256 bucketIndex_
    ) external useRandomActor(kickerIndex_) useRandomLenderBucket(bucketIndex_) useTimestamps {
        _kickWithDeposit(_lenderBucketIndex);
    }

    function withdrawBonds(
        uint256 kickerIndex_,
        uint256 maxAmount_
    ) external useRandomActor(kickerIndex_) useTimestamps {
        _withdrawBonds(_actor, maxAmount_);
    }

    /****************************/
    /*** Taker Test Functions ***/
    /****************************/

    function bucketTake(
        uint256 borrowerIndex_,
        uint256 bucketIndex_,
        bool depositTake_,
        uint256 takerIndex_
    ) external useRandomActor(takerIndex_) useTimestamps {
        numberOfCalls['BLiquidationHandler.bucketTake']++;

        borrowerIndex_ = constrictToRange(borrowerIndex_, 0, actors.length - 1);
        bucketIndex_   = constrictToRange(bucketIndex_, LENDER_MIN_BUCKET_INDEX, LENDER_MAX_BUCKET_INDEX);

        address borrower = actors[borrowerIndex_];
        address taker    = _actor;

        ( , , , uint256 kickTime, , , , , , ) = _pool.auctionInfo(borrower);

        if (kickTime == 0) _kickAuction(borrowerIndex_, 1e24, bucketIndex_);

        changePrank(taker);
        // skip time to make auction takeable
        vm.warp(block.timestamp + 2 hours);
        _bucketTake(taker, borrower, depositTake_, bucketIndex_);
    }

    /************************/
    /*** Helper Functions ***/
    /************************/

    function _kickAuction(
        uint256 borrowerIndex_,
        uint256 amount_,
        uint256 kickerIndex_
    ) internal useRandomActor(kickerIndex_) {
        numberOfCalls['BLiquidationHandler.kickAuction']++;

        borrowerIndex_   = constrictToRange(borrowerIndex_, 0, actors.length - 1);
        address borrower = actors[borrowerIndex_];
        address kicker   = _actor;
        amount_          = constrictToRange(amount_, MIN_AMOUNT, MAX_AMOUNT);

        ( , , , uint256 kickTime, , , , , , ) = _pool.auctionInfo(borrower);

        if (kickTime == 0) {
            (uint256 debt, , ) = _pool.borrowerInfo(borrower);

            if (debt == 0) {
                changePrank(borrower);
                _actor = borrower;
                uint256 drawDebtAmount = _preDrawDebt(amount_);
                _drawDebt(drawDebtAmount);

                // skip to make borrower undercollateralized
                vm.warp(block.timestamp + 200 days);
            }

            changePrank(kicker);
            _actor = kicker;
            _kickAuction(borrower);
        }
    }
}