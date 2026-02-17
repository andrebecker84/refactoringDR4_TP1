package com.gildedrose;

import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

class GildedRoseTest {

    private Item updateItem(String name, int sellIn, int quality) {
        Item[] items = new Item[]{new Item(name, sellIn, quality)};
        GildedRose app = new GildedRose(items);
        app.updateQuality();
        return items[0];
    }

    @Nested
    class NormalItem {

        @Test
        void qualityDecreasesByOneBeforeSellDate() {
            Item item = updateItem("Normal Item", 10, 20);
            assertThat(item.quality, is(19));
            assertThat(item.sellIn, is(9));
        }

        @Test
        void qualityDecreasesTwiceAfterSellDate() {
            Item item = updateItem("Normal Item", 0, 20);
            assertThat(item.quality, is(18));
            assertThat(item.sellIn, is(-1));
        }

        @Test
        void qualityNeverBecomesNegative() {
            Item item = updateItem("Normal Item", 5, 0);
            assertThat(item.quality, is(0));
        }

        @Test
        void qualityNeverBecomesNegativeAfterSellDate() {
            Item item = updateItem("Normal Item", 0, 1);
            assertThat(item.quality, is(0));
        }

        @Test
        void qualityDoesNotGoNegativeFromZeroAfterSellDate() {
            Item item = updateItem("Normal Item", -1, 0);
            assertThat(item.quality, is(0));
        }
    }

    @Nested
    class AgedBrie {

        @Test
        void qualityIncreasesByOneBeforeSellDate() {
            Item item = updateItem("Aged Brie", 10, 20);
            assertThat(item.quality, is(21));
            assertThat(item.sellIn, is(9));
        }

        @Test
        void qualityIncreasesTwiceAfterSellDate() {
            Item item = updateItem("Aged Brie", 0, 20);
            assertThat(item.quality, is(22));
            assertThat(item.sellIn, is(-1));
        }

        @Test
        void qualityNeverExceeds50() {
            Item item = updateItem("Aged Brie", 10, 50);
            assertThat(item.quality, is(50));
        }

        @Test
        void qualityNeverExceeds50AfterSellDate() {
            Item item = updateItem("Aged Brie", 0, 49);
            assertThat(item.quality, is(50));
        }
    }

    @Nested
    class Sulfuras {

        @Test
        void qualityAndSellInNeverChange() {
            Item item = updateItem("Sulfuras, Hand of Ragnaros", 10, 80);
            assertThat(item.quality, is(80));
            assertThat(item.sellIn, is(10));
        }

        @Test
        void qualityNeverChangesEvenWithNegativeSellIn() {
            Item item = updateItem("Sulfuras, Hand of Ragnaros", -1, 80);
            assertThat(item.quality, is(80));
            assertThat(item.sellIn, is(-1));
        }
    }

    @Nested
    class BackstagePass {

        private static final String BACKSTAGE = "Backstage passes to a TAFKAL80ETC concert";

        @Test
        void qualityIncreasesByOneWhenMoreThan10Days() {
            Item item = updateItem(BACKSTAGE, 15, 20);
            assertThat(item.quality, is(21));
            assertThat(item.sellIn, is(14));
        }

        @Test
        void qualityIncreasesByTwoWhen10DaysOrLess() {
            Item item = updateItem(BACKSTAGE, 10, 20);
            assertThat(item.quality, is(22));
        }

        @Test
        void qualityIncreasesByTwoWhen6Days() {
            Item item = updateItem(BACKSTAGE, 6, 20);
            assertThat(item.quality, is(22));
        }

        @Test
        void qualityIncreasesByThreeWhen5DaysOrLess() {
            Item item = updateItem(BACKSTAGE, 5, 20);
            assertThat(item.quality, is(23));
        }

        @Test
        void qualityIncreasesByThreeWhen1Day() {
            Item item = updateItem(BACKSTAGE, 1, 20);
            assertThat(item.quality, is(23));
        }

        @Test
        void qualityDropsToZeroAfterConcert() {
            Item item = updateItem(BACKSTAGE, 0, 20);
            assertThat(item.quality, is(0));
        }

        @Test
        void qualityNeverExceeds50() {
            Item item = updateItem(BACKSTAGE, 5, 49);
            assertThat(item.quality, is(50));
        }

        @Test
        void qualityNeverExceeds50AtMax() {
            Item item = updateItem(BACKSTAGE, 5, 50);
            assertThat(item.quality, is(50));
        }
    }

    @Nested
    class ConjuredItem {

        @Test
        void qualityDecreasesByTwoBeforeSellDate() {
            Item item = updateItem("Conjured Mana Cake", 10, 20);
            assertThat(item.quality, is(18));
            assertThat(item.sellIn, is(9));
        }

        @Test
        void qualityDecreasesByFourAfterSellDate() {
            Item item = updateItem("Conjured Mana Cake", 0, 20);
            assertThat(item.quality, is(16));
            assertThat(item.sellIn, is(-1));
        }

        @Test
        void qualityNeverBecomesNegative() {
            Item item = updateItem("Conjured Mana Cake", 5, 1);
            assertThat(item.quality, is(0));
        }

        @Test
        void qualityNeverBecomesNegativeAfterSellDate() {
            Item item = updateItem("Conjured Mana Cake", 0, 3);
            assertThat(item.quality, is(0));
        }

        @Test
        void qualityFromZeroStaysZero() {
            Item item = updateItem("Conjured Mana Cake", 5, 0);
            assertThat(item.quality, is(0));
        }

        @Test
        void anyConjuredItemIsRecognized() {
            Item item = updateItem("Conjured Elixir of the Mongoose", 10, 20);
            assertThat(item.quality, is(18));
        }
    }

    @Nested
    class MultipleItems {

        @Test
        void updatesAllItemsCorrectly() {
            Item[] items = new Item[]{
                    new Item("Normal Item", 5, 10),
                    new Item("Aged Brie", 3, 20),
                    new Item("Sulfuras, Hand of Ragnaros", 0, 80),
                    new Item("Backstage passes to a TAFKAL80ETC concert", 5, 30),
                    new Item("Conjured Mana Cake", 3, 10)
            };

            GildedRose app = new GildedRose(items);
            app.updateQuality();

            assertThat(items[0].quality, is(9));
            assertThat(items[1].quality, is(21));
            assertThat(items[2].quality, is(80));
            assertThat(items[3].quality, is(33));
            assertThat(items[4].quality, is(8));
        }
    }
}
