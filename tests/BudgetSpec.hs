module BudgetSpec (spec) where

import Budget

import Test.Hspec

spec :: Spec
spec =
    describe "main" $$ do
        it "returns the unit" $$
            main `shouldReturn` ()
