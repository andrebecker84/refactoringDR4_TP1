package com.gildedrose;

import net.jqwik.api.*;
import net.jqwik.api.constraints.IntRange;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

class GildedRosePropertyTest {

    private void updateNDays(GildedRose app, int days) {
        for (int i = 0; i < days; i++) {
            app.updateQuality();
        }
    }

    @Property
    void qualityIsNeverNegative(
            @ForAll("itemNames") String name,
            @ForAll @IntRange(min = -10, max = 30) int sellIn,
            @ForAll @IntRange(min = 0, max = 50) int quality,
            @ForAll @IntRange(min = 1, max = 100) int days
    ) {
        Item item = new Item(name, sellIn, quality);
        GildedRose app = new GildedRose(new Item[]{item});
        updateNDays(app, days);
        assertThat(item.quality, is(greaterThanOrEqualTo(0)));
    }

    @Property
    void sulfurasNeverChanges(
            @ForAll @IntRange(min = -10, max = 30) int sellIn,
            @ForAll @IntRange(min = 0, max = 80) int quality,
            @ForAll @IntRange(min = 1, max = 100) int days
    ) {
        Item item = new Item("Sulfuras, Hand of Ragnaros", sellIn, quality);
        int originalSellIn = item.sellIn;
        int originalQuality = item.quality;
        GildedRose app = new GildedRose(new Item[]{item});
        updateNDays(app, days);
        assertThat(item.sellIn, is(originalSellIn));
        assertThat(item.quality, is(originalQuality));
    }

    @Property
    void agedBrieQualityNeverExceeds50(
            @ForAll @IntRange(min = -10, max = 30) int sellIn,
            @ForAll @IntRange(min = 0, max = 50) int quality,
            @ForAll @IntRange(min = 1, max = 100) int days
    ) {
        Item item = new Item("Aged Brie", sellIn, quality);
        GildedRose app = new GildedRose(new Item[]{item});
        updateNDays(app, days);
        assertThat(item.quality, is(lessThanOrEqualTo(50)));
    }

    @Property
    void conjuredDegradesFasterThanNormal(
            @ForAll @IntRange(min = 1, max = 30) int sellIn,
            @ForAll @IntRange(min = 10, max = 50) int quality
    ) {
        Item normalItem = new Item("Normal Item", sellIn, quality);
        Item conjuredItem = new Item("Conjured Mana Cake", sellIn, quality);

        GildedRose normalApp = new GildedRose(new Item[]{normalItem});
        GildedRose conjuredApp = new GildedRose(new Item[]{conjuredItem});

        normalApp.updateQuality();
        conjuredApp.updateQuality();

        int normalLoss = quality - normalItem.quality;
        int conjuredLoss = quality - conjuredItem.quality;

        assertThat(conjuredLoss, is(greaterThanOrEqualTo(normalLoss)));
    }

    @Property
    void backstagePassQualityNeverExceeds50(
            @ForAll @IntRange(min = -5, max = 30) int sellIn,
            @ForAll @IntRange(min = 0, max = 50) int quality,
            @ForAll @IntRange(min = 1, max = 50) int days
    ) {
        Item item = new Item("Backstage passes to a TAFKAL80ETC concert", sellIn, quality);
        GildedRose app = new GildedRose(new Item[]{item});
        updateNDays(app, days);
        assertThat(item.quality, is(lessThanOrEqualTo(50)));
    }

    @Provide
    Arbitrary<String> itemNames() {
        return Arbitraries.of(
                "Normal Item",
                "Aged Brie",
                "Backstage passes to a TAFKAL80ETC concert",
                "Conjured Mana Cake",
                "Elixir of the Mongoose",
                "+5 Dexterity Vest"
        );
    }
}
