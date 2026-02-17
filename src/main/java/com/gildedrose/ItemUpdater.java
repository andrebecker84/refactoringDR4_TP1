package com.gildedrose;

/**
 * Strategy interface para atualizacao de itens.
 * Cada tipo de item possui sua propria implementacao.
 */
public interface ItemUpdater {

    void update(Item item);
}
