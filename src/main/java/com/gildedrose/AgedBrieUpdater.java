package com.gildedrose;

/**
 * Updater para "Aged Brie".
 * Qualidade aumenta com o tempo; dobra apos o vencimento.
 * Qualidade nunca excede 50.
 */
public class AgedBrieUpdater implements ItemUpdater {

    @Override
    public void update(Item item) {
        increaseQuality(item);
        item.sellIn--;
        if (item.sellIn < 0) {
            increaseQuality(item);
        }
    }

    private void increaseQuality(Item item) {
        if (item.quality < 50) {
            item.quality++;
        }
    }
}
