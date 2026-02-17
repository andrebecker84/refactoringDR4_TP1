package com.gildedrose;

import java.util.Map;

/**
 * Factory que resolve o ItemUpdater apropriado para cada item.
 * Utiliza um mapa imutavel de updaters singleton (stateless).
 */
public class ItemUpdaterFactory {

    private static final ItemUpdater DEFAULT_UPDATER = new DefaultUpdater();
    private static final ItemUpdater CONJURED_UPDATER = new ConjuredItemUpdater();

    private static final Map<String, ItemUpdater> UPDATERS = Map.of(
            "Aged Brie", new AgedBrieUpdater(),
            "Sulfuras, Hand of Ragnaros", new SulfurasUpdater(),
            "Backstage passes to a TAFKAL80ETC concert", new BackstagePassUpdater()
    );

    public ItemUpdater getUpdater(Item item) {
        if (item.name.startsWith("Conjured")) {
            return CONJURED_UPDATER;
        }
        return UPDATERS.getOrDefault(item.name, DEFAULT_UPDATER);
    }
}
