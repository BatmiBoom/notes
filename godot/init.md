# GODOT

A game is a _tree_ of _nodes_ that you group together into _scenes_. You can then wire these nodes so they can communicate using _signals_.

## SCENES

Break down your game into reusable scenes. A scene can be:

- Character
- Weapon
- Menu
- Single House
- Entire Level

Scenes are flexible; they fill the role of both prefabs and scenes in some other game engines.

You can also nest scenes. For example, you can put your character in a level, and drag and drop a scene as a child of it.

## NODES

A scene is composed of one or more _nodes_. Nodes are your game's smallest building blocks that you arrange into trees. Example of character's node.

```
- CharacterBody2D
    - Camera2D
    - Sprite2D
    - CollisionShape2D
```

When you save a tree of nodes as a scene, it then shows as a single node, with its internal structure hidden in the editor

## SCENE TREE

All scenes come together in the _scene tree_. It's easier to think of your game in terms of scenes as they can represent characters, weapons, door, or your user interface.

## SIGNALS

Nodes emit signals when some event occurs. This feature allows you to make nodes communicate without hard-wiring them in code.

> Signals are Godot's version of the _observer_ pattern

For example, buttons emit a signal when pressed. You can connect to this signal to run code in reaction to this event, like starting the game or opening a menu.

Other built-in signals can tell you when two objects collided, when a character or monster entered a given area, and much more. You can also define new signals tailored to your game.

## PROJECT
