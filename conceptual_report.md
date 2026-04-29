# UX Audit & Redesign Strategy: sdrtrunk Log Viewer
## Reference Framework: Apple Human Interface Guidelines (HIG)

### UX Audit: Violations of HIG Principles

1. **Clarity - Cramped Typography and List Density:** The current implementation uses dense `JTable` layouts with standard Swing rendering. The lack of adequate row height and padding violates the HIG principle of Clarity. Rows feel compressed, making it difficult to scan log entries quickly.
2. **Deference - Obtrusive Borders and Components:** The Swing UI utilizes heavy borders around tabs, tables, and search fields. According to Apple HIG, UI chrome should recede (Deference) to allow the data (the log content itself) to be the focal point. The standard `JTabbedPane` draws heavy, dated lines that distract from the task.
3. **Depth - Lack of Visual Hierarchy:** The Log Viewer presents everything at the exact same visual level. The "Analyze Error" button, refresh button, tabs, and search fields are all standard gray controls. HIG dictates using Depth and color to indicate interactivity, primary actions, and context. The System Health panel also lacks structural hierarchy, presenting everything as a flat HTML string.
4. **Context - Unintuitive Status Indication:** The System Health panel uses basic red/black HTML text for warnings. This lacks the standard, subtle visual indicators (like badges or progress rings) that Apple HIG recommends for quick status checks without overwhelming the user.

### Redesign Strategy

1. **Embrace "Deference" through Layout & Spacing:** Transition the layout to JavaFX (`BorderPane`, `VBox`, `HBox`) which provides superior control over margins and padding. We will increase row heights in the tables and use subtle, borderless aesthetics for the search fields and tabs.
2. **Enhance "Clarity" with Typography:** Utilize cleaner fonts (like San Francisco/Inter style if available, or system default sans-serif in JavaFX) with increased font sizes for primary data (Log Name) and softer, lighter grays for secondary data (Dates).
3. **Establish "Depth" via Visual Hierarchy:** Implement a primary action button style for the "Analyze Error" (Gemini AI) button to make it clear what the main interaction is. Group the "Refresh" and "Analyze" buttons into a cohesive toolbar rather than a detached bottom panel.

### Actionable Implementation Steps

1. **Refactor `LogsPanel.java` to JavaFX:** Convert the class from extending `JPanel` to extending `javafx.scene.layout.BorderPane`.
2. **Implement `TabPane`:** Replace `JTabbedPane` with JavaFX `TabPane`.
3. **Upgrade Tables:** Replace `JTable` with JavaFX `TableView<LogFile>`. Implement custom cell factories to handle date formatting cleanly.
4. **Modernize System Health:** Refactor `SystemHealthAdvisorTask` to update JavaFX `Label` or `Text` nodes directly using `Platform.runLater` instead of Swing HTML strings. Use JavaFX styling to highlight warnings.
5. **Restructure Interactions:** Move the search field and action buttons (Refresh, Analyze) into a unified toolbar or header area above the tables, creating a cleaner reading flow.
