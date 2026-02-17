package com.gildedrose;

/**
 * Updater para "Backstage passes to a TAFKAL80ETC concert".
 * Qualidade aumenta conforme o show se aproxima:
 * - +1 normalmente
 * - +2 quando faltam 10 dias ou menos
 * - +3 quando faltam 5 dias ou menos
 * - Zera apos o show (sellIn < 0)
 * Qualidade nunca excede 50.
 */
public class BackstagePassUpdater implements ItemUpdater {

    @Override
    public void update(Item item) {
        if (item.quality < 50) {
            item.quality++;
            if (item.sellIn <= 10 && item.quality < 50) {
                item.quality++;
            }
            if (item.sellIn <= 5 && item.quality < 50) {
                item.quality++;
            }
        }
        item.sellIn--;
        if (item.sellIn < 0) {
            item.quality = 0;
        }
    }
}
