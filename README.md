<div align="center">

![Instituto Infnet](https://img.shields.io/badge/Instituto-Infnet-red?style=for-the-badge)
![Curso](https://img.shields.io/badge/Curso-Engenharia_de_Software-blue?style=for-the-badge)
![Disciplina](https://img.shields.io/badge/Disciplina-Refatora%C3%A7%C3%A3o_(DR4)-green?style=for-the-badge)

# Gilded Rose Refactoring Kata
## Trabalho Pratico 1 - DR4 Refatoracao

![Java](https://img.shields.io/badge/Java-21-orange?logo=openjdk)
![Maven](https://img.shields.io/badge/Maven-3.9+-blue?logo=apachemaven)
![JUnit](https://img.shields.io/badge/JUnit-5-green?logo=junit5&logoColor=white)
![Jqwik](https://img.shields.io/badge/Jqwik-1.9.2-purple)
![JaCoCo](https://img.shields.io/badge/Coverage-JaCoCo-red?logo=codecov&logoColor=white)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg?logo=readme&logoColor=white)](LICENSE)
![Status](https://img.shields.io/badge/Status-Completo-success)

> **Refatoracao progressiva do Gilded Rose Kata aplicando Strategy Pattern, Factory, SOLID e testes automatizados**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-@becker84-0077B5?logo=linkedin)](https://linkedin.com/in/becker84)
[![GitHub](https://img.shields.io/badge/GitHub-@andrebecker84-181717?logo=github&logoColor=white)](https://github.com/andrebecker84)

</div>

---

## Indice

- [Sobre o Projeto](#sobre-o-projeto)
- [Problema Identificado](#problema-identificado)
- [Solucao Implementada](#solucao-implementada)
- [Tecnologias](#tecnologias)
- [Exercicios](#exercicios)
- [Como Executar](#como-executar)
- [Testes](#testes)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Decisoes Tecnicas](#decisoes-tecnicas)
- [Documentacao Completa](#documentacao-completa)

---

## Sobre o Projeto

O **Gilded Rose Kata** e um desafio classico de refatoracao que simula o sistema de controle de estoque de uma loja ficticia de itens magicos. O codigo original funciona, mas apresenta graves problemas estruturais: condicionais aninhadas, duplicacao de logica, mistura de responsabilidades e violacoes de principios fundamentais de design.

Este trabalho pratico consiste na refatoracao progressiva desse sistema legado, aplicando:

- **Strategy Pattern**: Polimorfismo substituindo condicionais complexas
- **Factory Pattern**: Encapsulamento da logica de resolucao de estrategias
- **SOLID**: Principios OCP, SRP e LSP aplicados de forma consistente
- **Testes Automatizados**: JUnit 5 + Hamcrest (deterministicos) e Jqwik (baseados em propriedades)
- **Clean Code**: Nomenclatura clara, metodos coesos, responsabilidades bem definidas

---

## Problema Identificado

O metodo `updateQuality()` original concentra toda a logica de negocio em uma unica estrutura monolitica:

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
            // ... mais 30+ linhas de condicionais aninhadas
        }
    }
}
```

### Bad Smells Identificados

| Categoria | Problema | Principio Violado |
|---|---|---|
| **Condicionais aninhadas** | if/else com 4+ niveis de profundidade | SRP, Clean Code |
| **Duplicacao** | Verificacoes de limites repetidas em varios pontos | DRY |
| **Responsabilidade excessiva** | Uma unica classe trata todos os tipos de item | SRP |
| **Rigidez** | Adicionar novo tipo exige modificar o metodo inteiro | OCP |
| **Nomenclatura** | Indices `i` em loops, sem metodos auxiliares | Clean Code |
| **Testabilidade** | Logica acoplada dificulta testes isolados | Testabilidade |

---

## Solucao Implementada

### Arquitetura Strategy + Factory

```
┌──────────────────────────────────────┐
│           GildedRose                 │  ← Orquestrador (itera itens)
├──────────────────────────────────────┤
│        ItemUpdaterFactory            │  ← Resolve updater por nome
├──────────────────────────────────────┤
│     ItemUpdater (interface)          │  ← Contrato Strategy
│  ┌────────────┬───────────────────┐  │
│  │ DefaultUpd │ AgedBrieUpdater   │  │
│  │ SulfurasUpd│ BackstagePassUpd  │  │
│  │ ConjuredUpd│                   │  │
│  └────────────┴───────────────────┘  │
├──────────────────────────────────────┤
│             Item                     │  ← Entidade original (inalterada)
└──────────────────────────────────────┘
```

### Antes vs Depois

| Aspecto | Antes | Depois |
|---|---|---|
| Linhas em `updateQuality()` | ~45 | 4 |
| Complexidade ciclomatica | Alta (condicionais aninhados) | Baixa (delegacao direta) |
| Para adicionar novo item | Modificar cadeia de if/else | Criar novo updater + registrar no factory |
| Testabilidade | Dificil (tudo acoplado) | Facil (cada updater testavel isoladamente) |
| Duplicacao | Verificacoes de limites repetidas | Centralizada em metodos protected |

---

## Tecnologias

| Tecnologia | Versao | Finalidade |
|---|---|---|
| Java | 21 | Linguagem principal |
| Maven | 3.9+ | Build e gerenciamento de dependencias |
| Spring Boot Parent | 3.4.2 | Gerenciamento de versoes de dependencias |
| JUnit 5 | 5.x | Testes unitarios deterministicos |
| Hamcrest | 2.x | Matchers para assercoes expressivas |
| Jqwik | 1.9.2 | Testes baseados em propriedades (Property-Based Testing) |
| JaCoCo | 0.8.12 | Analise de cobertura de codigo |

---

## Exercicios

| # | Exercicio | Descricao |
|---|---|---|
| 1 | Extracao de Metodos | Identificacao de blocos duplicados e extracao de metodos auxiliares (`decreaseQuality`, `increaseQuality`, `isExpired`) com nomes descritivos |
| 2 | Modularizacao | Padrao Strategy com Factory — cada tipo de item possui seu proprio updater, `GildedRose` delega via `ItemUpdaterFactory` |
| 3 | Itens Conjurados | `ConjuredItemUpdater` herda de `DefaultUpdater` e sobrescreve `decreaseQuality()` — sem alterar updaters existentes |
| 4 | Testes Automatizados | 26 testes deterministicos (JUnit 5 + Hamcrest) + 5 propriedades (Jqwik) cobrindo todos os tipos de item |
| 5 | Avaliacao de Design | Analise critica documentada em `GildedRose.java` — OCP, SRP e LSP justificados com base na arquitetura |

---

## Como Executar

### Pre-requisitos

- Java JDK 21 ou superior
- Maven 3.9 ou superior

### Execucao Rapida (Recomendado)

#### Windows
```bash
run.bat
```

#### Linux/macOS
```bash
chmod +x run.sh && ./run.sh
```

**Menu Interativo com Opcoes:**
1. Testes e Cobertura (JUnit 5 + Jqwik + JaCoCo)
2. Compilar Projeto
3. Limpar Build
4. Gerar JavaDoc
5. Abrir Relatorios JaCoCo
6. Documentacao
7. Verificar Pre-requisitos
0. Sair

### Comandos Maven

```bash
# Compilar, testar e gerar relatorio de cobertura
mvn clean verify

# Apenas testes
mvn test

# Compilar sem testes
mvn clean compile

# Gerar JAR
mvn package -DskipTests
```

### Relatorio de Cobertura

Apos `mvn verify`, o relatorio JaCoCo esta disponivel em:

```
target/site/jacoco/index.html
```

---

## Testes

### Testes Deterministicos (`GildedRoseTest.java`)

Organizados com `@Nested` por tipo de item:

| Classe | Testes | Cenarios Cobertos |
|---|---|---|
| `NormalItem` | 5 | Degradacao normal, pos-vencimento, limite zero |
| `AgedBrie` | 4 | Aumento de qualidade, pos-vencimento, teto 50 |
| `Sulfuras` | 2 | Imutabilidade de qualidade e sellIn |
| `BackstagePass` | 8 | +1, +2, +3, zera pos-show, teto 50 |
| `ConjuredItem` | 6 | Degradacao 2x, 4x pos-vencimento, limite zero, deteccao por prefixo |
| `MultipleItems` | 1 | Atualizacao simultanea de multiplos tipos |

### Testes Baseados em Propriedades (`GildedRosePropertyTest.java`)

| Propriedade | Descricao |
|---|---|
| `qualityIsNeverNegative` | Para qualquer item e N dias, qualidade >= 0 |
| `sulfurasNeverChanges` | Sulfuras mantem qualidade e sellIn inalterados |
| `agedBrieQualityNeverExceeds50` | Aged Brie nunca ultrapassa 50 |
| `conjuredDegradesFasterThanNormal` | Conjured perde mais qualidade que normal no mesmo cenario |
| `backstagePassQualityNeverExceeds50` | Backstage pass nunca ultrapassa 50 |

### Exemplo de Teste

```java
@Test
void qualityDecreasesByFourAfterSellDate() {
    Item item = updateItem("Conjured Mana Cake", 0, 20);
    assertThat(item.quality, is(16));
    assertThat(item.sellIn, is(-1));
}
```

---

## Estrutura do Projeto

```
refactoringDR4_TP1/
│
├── src/
│   ├── main/java/com/gildedrose/
│   │   ├── Item.java                 # Classe original (inalterada)
│   │   ├── GildedRose.java           # Classe principal refatorada + avaliacao de design
│   │   ├── ItemUpdater.java          # Interface Strategy
│   │   ├── ItemUpdaterFactory.java   # Factory para resolucao de updaters
│   │   ├── DefaultUpdater.java       # Itens normais (metodos protected para extensao)
│   │   ├── AgedBrieUpdater.java      # Aged Brie
│   │   ├── SulfurasUpdater.java      # Sulfuras (lendario)
│   │   ├── BackstagePassUpdater.java # Backstage passes
│   │   └── ConjuredItemUpdater.java  # Itens conjurados (extends DefaultUpdater, 2x)
│   │
│   └── test/java/com/gildedrose/
│       ├── GildedRoseTest.java           # 26 testes deterministicos
│       └── GildedRosePropertyTest.java   # 5 propriedades Jqwik
│
├── doc/
│   ├── DOCUMENTACAO_TP1.md               # Documentacao detalhada dos 5 exercicios
│   └── images/
│       └── card.svg
│
├── pom.xml
├── run.bat                               # Script de execucao (Windows)
├── run.sh                                # Script de execucao (Linux/macOS)
├── README.md
├── LICENSE
└── .gitignore
```

---

## Decisoes Tecnicas

### 1. DefaultUpdater com Metodos Protected

Permite que `ConjuredItemUpdater` herde e sobrescreva apenas `decreaseQuality()`, sem duplicar logica. Metodos `protected` oferecem extensao controlada sem expor internals publicamente.

### 2. Factory com `startsWith("Conjured")`

Trata qualquer variante de item conjurado (ex: "Conjured Mana Cake", "Conjured Elixir of the Mongoose") de forma flexivel, sem necessidade de registrar cada variante individualmente.

### 3. Updaters Stateless (Singleton)

Instancias compartilhadas via `Map.of()` e campos `static` no factory. Sem estado mutavel, sem necessidade de criar novas instancias a cada chamada.

### 4. Item.java Inalterado

Respeita a restricao do kata original — o goblin nao permite alteracoes na classe `Item`.

### 5. Exercicio 1 como Etapa Intermediaria

A extracao de metodos (`decreaseQuality`, `increaseQuality`, `isExpired`) e documentada como passo intermediario. O codigo final evolui para o padrao Strategy (Exercicio 2), onde esses metodos sao distribuidos entre os updaters especializados.

---

## Documentacao Completa

A documentacao detalhada de cada exercicio, incluindo trechos de codigo antes/depois, principios aplicados e justificativas tecnicas, esta disponivel em:

**[doc/DOCUMENTACAO_TP1.md](doc/DOCUMENTACAO_TP1.md)**

### Referencias Tecnicas

- *Clean Code: A Handbook of Agile Software Craftsmanship* — Robert C. Martin
- *Refactoring: Improving the Design of Existing Code* — Martin Fowler
- [Gilded Rose Refactoring Kata](https://github.com/emilybache/GildedRose-Refactoring-Kata) — Emily Bache

---

<div align="center">

**Desenvolvido como Trabalho Pratico da disciplina de Engenharia de Software com foco em Refatoracao.**

[![Java](https://img.shields.io/badge/Made%20with-Java-orange?logo=openjdk)](https://www.java.com/)
[![Maven](https://img.shields.io/badge/Built%20with-Maven-blue?logo=apache-maven)](https://maven.apache.org/)
[![JUnit](https://img.shields.io/badge/Tested%20with-JUnit-green?logo=junit5&logoColor=white)](https://junit.org/junit5/)

<img src="doc/images/card.svg" width="360" alt="Andre Luis Becker - Software Engineer" />

*Instituto Infnet - Engenharia de Software - 2026.*

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg?logo=readme&logoColor=white)](LICENSE)

</div>
