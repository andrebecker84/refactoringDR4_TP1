package com.gildedrose;

/**
 * Updater para itens normais.
 * Qualidade degrada 1x por dia; 2x apos o vencimento.
 * Qualidade nunca fica negativa.
 */
public class DefaultUpdater implements ItemUpdater {

    @Override
    public void update(Item item) {
        decreaseQuality(item);
        item.sellIn--;
        if (isExpired(item)) {
            decreaseQuality(item);
        }
    }

    protected void decreaseQuality(Item item) {
        if (item.quality > 0) {
            item.quality--;
        }
    }

    protected boolean isExpired(Item item) {
        return item.sellIn < 0;
    }
}
