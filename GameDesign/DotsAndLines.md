Game Design: Dots and Lines
=====================

Copyright (c) 2019 Wang Huaqiang

---
<!-- TOC -->

- [1. Introduction](#1-introduction)
    - [1.1. Design Requirements](#11-design-requirements)
- [2. Basic Idea: Seize Blocks](#2-basic-idea-seize-blocks)
- [3. How did this idea come to shape](#3-how-did-this-idea-come-to-shape)
- [4. Advanced Idea: Trade War](#4-advanced-idea-trade-war)
    - [4.1. Improve the game](#41-improve-the-game)
    - [4.2. The New Design](#42-the-new-design)
        - [4.2.1. Ways to win](#421)
        - [4.2.2. Winning Condition](#422-winning-condition)
    - [4.3. Some Strategies for this Game](#43-some-strategies-for-this-game)
    - [4.4. Proof of Fairness](#44-proof-of-fairness)
- [5. Further Improvements](#5-further-improvements)

<!-- /TOC -->
---

# 1. Introduction

We choose to start from the game's mechanics. Inspired by another assignment, we would like to make a take-turn grid game.

---

## 1.1. Design Requirements

* Playable with only simple pens and paper
* Try to reduce the difference between the fist player and the second
* Interaction between players

As we want this game to be playable with simple pens and paper, the game should not be too difficult: that means the judge of winner should be easy enough, and the mechanic should be performable without a computer.

Another point is that the game should be fair. For most board games, the first player to have his turn have great advantage, if no special rules are introduced. Take Tic-Toe for example, in traditional Tic-Toe games, the first player will never lose the game if he takes the right choice.

---

# 2. Basic Idea: Seize Blocks

The basic version of this game is as following:

Take a grid board. 2 players take turns to add points and lines into this board. In each turn, a player can add one point and one line with color. Especially, the first player can only add a dot in his first turn.

The dot is neutral, which means both two players can use them. Different from dots, the lines have different colors, and belong to different players.

The aim of this game is to take bonus blocks (1x1 areas on board) in the board. In each game the blocks is picked randomly or by the first player or the two players take turns to choose them. The way to take a bonus block is surround it with lines in the same color. The winner is the one who is able to take half of the controllable blocks.

---

# 3. How did this idea come to shape

Why bonus blocks is needed?
How many blocks are needed?

---

# 4. Advanced Idea: Trade War

## 4.1. Improve the game

Problems:

* fair
* theme
* more choices

* Add up the complexity
* Introduce the third player
* Add up random mechanics

---

## 4.2. The New Design

The new game needs at least 3 players. Following is trems used in the new game.

<!-- As the new game is a little bit complicated, here we erms: -->

Elements|Description
-|-
City|Dots belongs to different players
Trade Line|Lines between two cities, two Trade Lines can not cross
Trade Points|The winner is the player who has the most trade points
Domestic Trade|Trade line between 2 cities which belong to a single player
International Trade|Trade line between 2 cities which belong to two different players
Land|Cities can only be built on lands
Water Area|Trade Line can only be between Port Cities
Port Cities|Cities on sea shore (sea shore is within 1 blocks)
Control Zone|Areas which is surround by trade lines, now new city or trade line can be built in a c-zone

### 4.2.1. Ways to win

There are three ways to get points:

1. Each Trade Line between two players provides 1 point for each players
1. A player can get 1 point if he takes part in all the trade lines form a control zone. 
1. Extra bonus will be given to the owner of a control zone (if exist) for each city in this control zone. 

### 4.2.2. Winning Condition

The game ends when:

1. Reached pre-pointed turns
1. No new city/trade line can be built
1. A player has no less than 4 cities inside a control zone.

For end condition 1 and 2, the player who has the most trade points wins. For end condition 3, the player got no less than 4 cities inside a control zone wins.

---

## 4.3. Some Strategies for this Game

<!-- Omitted here. -->

* Build a wall
* Isolationism
* Let your city become the trade center
* Use international trade lines to prevent other players from setting up a "super zone"

---

## 4.4. Proof of Fairness

Omitted here.

---

# 5. Further Improvements