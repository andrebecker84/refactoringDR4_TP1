# Documentacao - Trabalho Pratico 1 (DR4 - Refatoracao)

## Gilded Rose Refactoring Kata

---

## Exercicio 1 - Extracao de Metodos

### Objetivo

Identificar e extrair blocos logicos do metodo monolitico `updateQuality()` original, como etapa intermediaria antes da modularizacao completa.

### Codigo Original

O metodo original consiste em uma cadeia de `if/else` aninhados que mistura a logica de todos os tipos de itens:

```java
public void updateQuality() {
    for (int i = 0; i < items.length; i++) {
        if (!items[i].name.equals("Aged Brie")
                && !items[i].name.equals("Backstage passes to a TAFKAL80ETC concert")) {
            if (items[i].quality > 0) {
                if (!items[i].name.equals("Sulfuras, Hand of Ragnaros")) {
                    items[i].quality = items[i].quality - 1;
                }
            }
        } else {
            if (items[i].quality < 50) {
                items[i].quality = items[i].quality + 1;
                if (items[i].name.equals("Backstage passes to a TAFKAL80ETC concert")) {
                    if (items[i].sellIn < 11) {
                        if (items[i].quality < 50) {
                            items[i].quality = items[i].quality + 1;
                        }
                    }
                    if (items[i].sellIn < 6) {
                        if (items[i].quality < 50) {
                            items[i].quality = items[i].quality + 1;
                        }
                    }
                }
            }
        }
        // ... mais condicionais para sellIn e pos-vencimento
    }
}
```

### Refatoracao Intermediaria

O primeiro passo foi extrair metodos privados por tipo de item dentro da propria classe `GildedRose`, eliminando as condicionais aninhadas e atribuindo nomes descritivos a cada bloco de logica:

```java
public class GildedRose {
    Item[] items;

    public GildedRose(Item[] items) {
        this.items = items;
    }

    public void updateQuality() {
        for (Item item : items) {
            switch (item.name) {
                case "Aged Brie" -> updateAgedBrie(item);
                case "Sulfuras, Hand of Ragnaros" -> updateSulfuras(item);
                case "Backstage passes to a TAFKAL80ETC concert" -> updateBackstagePass(item);
                default -> updateNormalItem(item);
            }
        }
    }

    private void updateNormalItem(Item item) {
        decreaseQuality(item);
        item.sellIn--;
        if (isExpired(item)) {
            decreaseQuality(item);
        }
    }

    private void updateAgedBrie(Item item) {
        increaseQuality(item);
        item.sellIn--;
        if (isExpired(item)) {
            increaseQuality(item);
        }
    }

    private void updateSulfuras(Item item) {
        // Item lendario: nao sofre alteracoes
    }

    private void updateBackstagePass(Item item) {
        increaseQuality(item);
        if (item.sellIn <= 10) { increaseQuality(item); }
        if (item.sellIn <= 5)  { increaseQuality(item); }
        item.sellIn--;
        if (isExpired(item)) {
            item.quality = 0;
        }
    }

    private void decreaseQuality(Item item) {
        if (item.quality > 0) { item.quality--; }
    }

    private void increaseQuality(Item item) {
        if (item.quality < 50) { item.quality++; }
    }

    private boolean isExpired(Item item) {
        return item.sellIn < 0;
    }
}
```

### Metodos Extraidos

Foram extraidos **sete metodos privados** com nomes autoexplicativos:

| Metodo | Responsabilidade |
|---|---|
| `updateNormalItem(Item)` | Logica de degradacao de itens comuns |
| `updateAgedBrie(Item)` | Logica de aumento de qualidade do Aged Brie |
| `updateSulfuras(Item)` | Garantia de imutabilidade do item lendario |
| `updateBackstagePass(Item)` | Logica de incremento progressivo dos backstage passes |
| `decreaseQuality(Item)` | Diminuir qualidade com verificacao de limite inferior (0) |
| `increaseQuality(Item)` | Aumentar qualidade com verificacao de teto (50) |
| `isExpired(Item)` | Verificar se o item passou do vencimento |

### Bad Smells Eliminados

- **Condicionais aninhadas**: O `switch` no `updateQuality()` substitui a cadeia de `if/else` com 4+ niveis de profundidade
- **Duplicacao**: As verificacoes `quality > 0` e `quality < 50` foram centralizadas em `decreaseQuality()` e `increaseQuality()`
- **Metodo longo**: O metodo original de ~45 linhas foi decomposto em metodos coesos de 3-7 linhas cada

### Principios Aplicados

- **DRY (Don't Repeat Yourself)**: Logica de verificacao de limites centralizada em `decreaseQuality()` e `increaseQuality()`
- **SRP (parcial)**: Cada metodo extraido tem uma responsabilidade clara, mas a classe ainda concentra todos os tipos de item — limitacao resolvida no Exercicio 2
- **Clean Code**: Nomes descritivos eliminam a necessidade de comentarios; cada metodo e curto e objetivo

### Resultado

Esta etapa eliminou os bad smells mais criticos (condicionais aninhadas, duplicacao, metodo longo) e serviu como base para o Exercicio 2, onde os metodos extraidos sao reorganizados em classes separadas (updaters), completando a separacao de responsabilidades.

---

## Exercicio 2 - Modularizacao com Padrao Strategy + Factory

### Objetivo

Eliminar a cadeia de condicionais aplicando o padrao **Strategy** (cada tipo de item tem seu proprio updater) combinado com **Factory** (resolucao automatica do updater correto).

### Arquitetura

```
ItemUpdater (interface)
├── DefaultUpdater        (itens normais)
├── AgedBrieUpdater       (Aged Brie)
├── SulfurasUpdater       (Sulfuras)
├── BackstagePassUpdater  (Backstage passes)
└── ConjuredItemUpdater   (extends DefaultUpdater)

ItemUpdaterFactory        (resolve updater por nome do item)
```

### Interface Strategy

```java
public interface ItemUpdater {
    void update(Item item);
}
```

### DefaultUpdater (metodos protected para extensao)

```java
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
```

### Factory com Mapa Imutavel

```java
public class ItemUpdaterFactory {
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
```

### GildedRose Simplificado

```java
public void updateQuality() {
    for (Item item : items) {
        ItemUpdater updater = factory.getUpdater(item);
        updater.update(item);
    }
}
```

### Antes vs Depois

| Aspecto | Antes | Depois |
|---|---|---|
| Linhas em `updateQuality()` | ~45 | 4 |
| Complexidade ciclomatica | Alta (condicionais aninhados) | Baixa (delegacao direta) |
| Para adicionar novo item | Modificar cadeia de if/else | Criar novo updater + registrar no factory |
| Testabilidade | Dificil (tudo acoplado) | Facil (cada updater testavel isoladamente) |

### Principios Aplicados

- **OCP**: Novos tipos de item sao adicionados sem modificar codigo existente
- **SRP**: Cada updater encapsula a logica de um unico tipo de item
- **Strategy Pattern**: Polimorfismo substitui condicionais
- **Factory Pattern**: Encapsula a logica de criacao/resolucao

---

## Exercicio 3 - Itens Conjurados

### Objetivo

Implementar o comportamento de itens "Conjured", que degradam em qualidade 2x mais rapido que itens normais.

### Implementacao

`ConjuredItemUpdater` herda de `DefaultUpdater` e sobrescreve apenas `decreaseQuality()`:

```java
public class ConjuredItemUpdater extends DefaultUpdater {
    @Override
    protected void decreaseQuality(Item item) {
        super.decreaseQuality(item);
        super.decreaseQuality(item);
    }
}
```

### Registro no Factory

O factory detecta itens conjurados pelo prefixo "Conjured" no nome:

```java
if (item.name.startsWith("Conjured")) {
    return CONJURED_UPDATER;
}
```

Isso permite tratar qualquer variante (ex: "Conjured Mana Cake", "Conjured Elixir of the Mongoose").

### Principios Aplicados

- **OCP**: Nenhum updater existente foi modificado para adicionar itens conjurados
- **LSP**: `ConjuredItemUpdater` e substituivel por `DefaultUpdater` — mantem o contrato (qualidade >= 0, sellIn decrementado)
- **Heranca com proposito**: A heranca e justificada porque itens conjurados **sao** itens normais com degradacao acelerada

### Comportamento

| Cenario | Normal | Conjured |
|---|---|---|
| Antes do vencimento | -1/dia | -2/dia |
| Apos vencimento | -2/dia | -4/dia |
| Qualidade minima | 0 | 0 |

---

## Exercicio 4 - Testes Automatizados

### Objetivo

Criar uma suite de testes abrangente usando JUnit 5, Hamcrest e Jqwik para garantir a corretude da refatoracao.

### Testes Deterministicos (`GildedRoseTest.java`)

Organizados com `@Nested` por tipo de item:

| Classe | Testes | Cenarios cobertos |
|---|---|---|
| `NormalItem` | 5 | Degradacao normal, pos-vencimento, limite zero |
| `AgedBrie` | 4 | Aumento de qualidade, pos-vencimento, teto 50 |
| `Sulfuras` | 2 | Imutabilidade de qualidade e sellIn |
| `BackstagePass` | 8 | +1, +2, +3, zera pos-show, teto 50 |
| `ConjuredItem` | 6 | Degradacao 2x, 4x pos-vencimento, limite zero, deteccao por prefixo |
| `MultipleItems` | 1 | Atualizacao simultanea de multiplos tipos |

**Total: 26 testes deterministicos**

### Exemplo de Teste

```java
@Test
void qualityDecreasesByTwoBeforeSellDate() {
    Item item = updateItem("Conjured Mana Cake", 10, 20);
    assertThat(item.quality, is(18));
    assertThat(item.sellIn, is(9));
}
```

### Testes Baseados em Propriedades (`GildedRosePropertyTest.java`)

Usando Jqwik para verificar invariantes em cenarios aleatorios:

| Propriedade | Descricao |
|---|---|
| `qualityIsNeverNegative` | Para qualquer item e N dias, qualidade >= 0 |
| `sulfurasNeverChanges` | Sulfuras mantem qualidade e sellIn inalterados |
| `agedBrieQualityNeverExceeds50` | Aged Brie nunca ultrapassa 50 |
| `conjuredDegradesFasterThanNormal` | Conjured perde mais qualidade que normal no mesmo cenario |
| `backstagePassQualityNeverExceeds50` | Backstage pass nunca ultrapassa 50 |

### Ferramentas Utilizadas

- **JUnit 5**: Framework de testes com suporte a `@Nested` para organizacao hierarquica
- **Hamcrest**: Matchers como `is()`, `greaterThanOrEqualTo()`, `lessThanOrEqualTo()` para assercoes legíveis
- **Jqwik**: Geracao automatica de dados para testes baseados em propriedades

---

## Exercicio 5 - Avaliacao de Design

### Objetivo

Avaliar criticamente o design final do sistema, identificando os principios SOLID aplicados e as decisoes de design tomadas.

### Avaliacao (documentada em `GildedRose.java`)

#### OCP - Open/Closed Principle

A classe `GildedRose` esta **fechada para modificacao** e **aberta para extensao**. Para adicionar um novo tipo de item:

1. Criar uma nova classe implementando `ItemUpdater`
2. Registrar no `ItemUpdaterFactory`
3. Nenhuma alteracao em `GildedRose.java` ou nos updaters existentes

#### SRP - Single Responsibility Principle

Cada componente tem uma unica responsabilidade:

| Componente | Responsabilidade |
|---|---|
| `GildedRose` | Orquestrar a iteracao sobre itens |
| `ItemUpdaterFactory` | Resolver o updater correto para cada item |
| `DefaultUpdater` | Logica de atualizacao de itens normais |
| `AgedBrieUpdater` | Logica de atualizacao do Aged Brie |
| `SulfurasUpdater` | Garantir imutabilidade do Sulfuras |
| `BackstagePassUpdater` | Logica de atualizacao dos backstage passes |
| `ConjuredItemUpdater` | Logica de degradacao acelerada |

#### LSP - Liskov Substitution Principle

`ConjuredItemUpdater` estende `DefaultUpdater` e pode ser usado em qualquer contexto que espera um `DefaultUpdater` ou `ItemUpdater`. O contrato e mantido:

- Qualidade nunca fica negativa
- `sellIn` e decrementado normalmente
- A degradacao e um refinamento (mais rapida) do comportamento base

### Decisoes de Design

1. **Updaters stateless/singleton**: Instancias compartilhadas via `Map.of()` e campos `static`, evitando alocacoes desnecessarias
2. **Factory com `startsWith("Conjured")`**: Flexivel para qualquer variante de item conjurado
3. **Metodos `protected` em `DefaultUpdater`**: Permitem extensao controlada por subclasses sem expor internals publicamente
4. **`Item.java` inalterado**: Respeita a restricao do kata original (o goblin nao permite alteracoes)

---

## Conclusao

A refatoracao transformou um metodo monolitico com alta complexidade ciclomatica em uma arquitetura modular baseada em **Strategy + Factory**. O codigo resultante e:

- **Extensivel**: Novos tipos de item sao adicionados sem modificar codigo existente
- **Testavel**: Cada componente pode ser testado isoladamente
- **Legivel**: O fluxo principal (`GildedRose.updateQuality()`) tem apenas 4 linhas
- **Robusto**: 26 testes deterministicos + 5 propriedades Jqwik garantem a corretude

---

## Referencias

- MARTIN, Robert C. *Clean Code: A Handbook of Agile Software Craftsmanship*. 2nd Edition. Prentice Hall, 2008.
- FOWLER, Martin. *Refactoring: Improving the Design of Existing Code*. 2nd Edition. Addison-Wesley, 2018.
- BACHE, Emily. [Gilded Rose Refactoring Kata](https://github.com/emilybache/GildedRose-Refactoring-Kata). GitHub.
- GAMMA, Erich et al. *Design Patterns: Elements of Reusable Object-Oriented Software*. Addison-Wesley, 1994.
- [JUnit 5 User Guide](https://junit.org/junit5/docs/current/user-guide/). junit.org.
- [Jqwik User Guide](https://jqwik.net/docs/current/user-guide.html). jqwik.net.
