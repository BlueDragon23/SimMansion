
```mermaid
---
title: Conceptual structure
---
classDiagram
	class Main {
	}
	namespace UI {
		class Gui {
		}
		class EventPanel {
		}
		class ResourcePanel {
		}
		class ActionPanel {
		}
		class HousePanel {
		}
	}
	namespace State {
		class StateManager {
		}
		class RoomManager {
		}
		class EventManager {
		}
	}
	namespace Glue {
		class RoomConnector {
		}
		class EventConnector {
		}
	}
	note for RoomConnector "This handles joining RoomManager with UI that needs room state"
	StateManager --> RoomManager
	StateManager --> EventManager
	Main --> StateManager
	Main --> Gui
	Gui --> EventPanel
	Gui --> ResourcePanel
	Gui --> ActionPanel
	Gui --> HousePanel
	HousePanel --> ActionPanel : Update selection state
	
	RoomConnector --> RoomManager
	RoomConnector --> ResourcePanel
	RoomConnector --> HousePanel
	
	EventConnector --> EventManager
	EventConnector --> EventPanel
```

There's kind of three things going on here. There's the UI layout structure, then the state, then the events that need to update both. I somewhat already have the state modelled, so I guess this is more about UI elements and what joins things together. Where is the glue?