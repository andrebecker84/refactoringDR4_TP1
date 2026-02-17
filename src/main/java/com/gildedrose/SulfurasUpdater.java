package com.gildedrose;

/**
 * Updater para "Sulfuras, Hand of Ragnaros".
 * Item lendario: qualidade e sellIn nunca mudam.
 */
public class SulfurasUpdater implements ItemUpdater {

    @Override
    public void update(Item item) {
        // Sulfuras e um item lendario — nao sofre alteracoes.
    }
}
