package com.gildedrose;

/**
 * Classe principal refatorada do Gilded Rose Kata.
 *
 * O metodo updateQuality() original foi refatorado em duas etapas:
 * - Exercicio 1: Extracao de metodos privados por tipo de item (updateAgedBrie,
 *   updateSulfuras, updateBackstagePass, updateNormalItem) dentro desta classe.
 * - Exercicio 2: Evolucao para o padrao Strategy + Factory, delegando a logica
 *   de cada tipo a um ItemUpdater especializado via ItemUpdaterFactory.
 *
 * ──────────────────────────────────────────────────────────────────────────────
 * Exercicio 5 - Avaliacao de Design
 * ──────────────────────────────────────────────────────────────────────────────
 *
 * 1) A estrutura atual facilita a adicao de novos tipos de item?
 *    Sim. O padrao Strategy + Factory garante aderencia ao Principio Aberto-Fechado
 *    (OCP): para adicionar um novo tipo de item, basta criar uma nova classe que
 *    implemente ItemUpdater e registra-la no ItemUpdaterFactory. Nenhuma alteracao
 *    e necessaria em GildedRose, nos updaters existentes ou nos testes ja escritos.
 *    A adicao de ConjuredItemUpdater (Exercicio 3) comprovou isso na pratica.
 *
 * 2) A implementacao dos ItemUpdater respeita o Principio da Responsabilidade Unica?
 *    Sim. Cada updater encapsula exclusivamente a logica de atualizacao de um unico
 *    tipo de item: DefaultUpdater trata itens normais, AgedBrieUpdater trata Aged Brie,
 *    SulfurasUpdater garante a imutabilidade do Sulfuras, BackstagePassUpdater trata
 *    os backstage passes e ConjuredItemUpdater trata itens conjurados. GildedRose se
 *    limita a orquestrar a iteracao, e ItemUpdaterFactory encapsula a resolucao.
 *
 * 3) Alguma violacao do Principio de Substituicao de Liskov na hierarquia?
 *    Nao. ConjuredItemUpdater estende DefaultUpdater e sobrescreve apenas
 *    decreaseQuality(), chamando super.decreaseQuality() duas vezes. O contrato
 *    do tipo base e integralmente preservado: qualidade nunca fica negativa,
 *    sellIn e decrementado, e a degradacao acelerada e um refinamento valido
 *    (nao uma violacao) do comportamento herdado. Qualquer contexto que espera
 *    um DefaultUpdater ou ItemUpdater pode receber um ConjuredItemUpdater sem
 *    efeitos colaterais inesperados.
 */
public class GildedRose {

    Item[] items;

    private final ItemUpdaterFactory factory = new ItemUpdaterFactory();

    public GildedRose(Item[] items) {
        this.items = items;
    }

    public void updateQuality() {
        for (Item item : items) {
            ItemUpdater updater = factory.getUpdater(item);
            updater.update(item);
        }
    }
}
