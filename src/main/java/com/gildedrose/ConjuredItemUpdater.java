package com.gildedrose;

/**
 * Updater para itens "Conjured".
 * Degrada em qualidade 2x mais rapido que itens normais.
 * Herda de DefaultUpdater e sobrescreve decreaseQuality().
 */
public class ConjuredItemUpdater extends DefaultUpdater {

    @Override
    protected void decreaseQuality(Item item) {
        super.decreaseQuality(item);
        super.decreaseQuality(item);
    }
}
