---
source: RedmineKeyboardNavigation
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineKeyboardNavigation
source_version: 14
source_updated_on: '2026-10-13T05:22:18Z'
---

# Keyboard Navigation

Redmine has two kinds of keyboard shortcuts: accesskeys, which are provided by the browser, and shortcuts that Redmine handles itself and that therefore work the same way in every browser.

## Accesskeys

Some functions in Redmine can be accessed using accesskeys.\
The modifier keys used to trigger an accesskey vary between browsers and operating systems:

| Browser | Windows | macOS | Linux | Comments |
|----|----|----|----|----|
| **Chrome** | Alt | Ctrl + Option | Alt + Shift | Accesskeys **7** and **4** are not available on Windows and Linux. On Windows, use Alt + Shift instead for the accesskeys **e** and **f**. |
| **Firefox** | Alt + Shift | Ctrl + Option | Alt + Shift |  |
| **Safari** | n/a | Ctrl + Option | n/a | Safari is available on macOS only. |
| **Edge** | Alt | Ctrl + Option | Alt + Shift | Same as Chrome. |

### Shortcuts using accesskeys

In the table below, \<Accesskey\> stands for the modifier keys listed above for your browser and operating system.

<table>
<thead>
<tr>
<th>Keyboard shortcut</th>
<th>Description</th>
<th>Available in</th>
</tr>
</thead>
<tbody>
<tr>
<td>&lt;Accesskey&gt; + 7</td>
<td>Creates a new issue.</td>
<td>Anywhere in a project where you can add issues, unless “Project menu tab for creating new objects” is set to “none”.</td>
</tr>
<tr>
<td>&lt;Accesskey&gt; + 4</td>
<td>Opens the search page.</td>
<td>Anywhere (project search inside a project, global search elsewhere).</td>
</tr>
<tr>
<td>&lt;Accesskey&gt; + n</td>
<td>Moves forward.</td>
<td><ul>
<li>issue pages with previous/next issue navigation</li>
<li>paginated lists</li>
<li>activity pages</li>
<li>months in the calendar view</li>
<li>periods in the Gantt view</li>
<li>revisions in the repository</li>
</ul></td>
</tr>
<tr>
<td>&lt;Accesskey&gt; + p</td>
<td>Moves backward.</td>
<td><ul>
<li>issue pages with previous/next issue navigation</li>
<li>paginated lists</li>
<li>activity pages</li>
<li>months in the calendar view</li>
<li>periods in the Gantt view</li>
<li>revisions in the repository</li>
</ul></td>
</tr>
<tr>
<td>&lt;Accesskey&gt; + f</td>
<td>Moves the cursor into the quick search field.</td>
<td>Pages with the quick search field in the header bar.</td>
</tr>
<tr>
<td>&lt;Accesskey&gt; + e</td>
<td>Switches to edit mode or moves the cursor into the text area.</td>
<td>Issues, wiki pages, news, documents and forum messages.</td>
</tr>
</tbody>
</table>

## Non-accesskey shortcuts

The following shortcuts are handled by Redmine itself and therefore work the same way in every browser.

### Navigation shortcuts

| Keyboard shortcut | Description | Available in |
|----|----|----|
| → | Moves to the next file. | Attachment previews and file pages in the repository browser. **Available in version 4.0 or higher.** |
| ← | Moves to the previous file. | Attachment previews and file pages in the repository browser. **Available in version 4.0 or higher.** |
| ↑ / ↓ | Moves through the items. | Project jump box. |
| Home / End | Moves to the first / last item. | Project jump box. |

### Text editor shortcuts

| Keyboard shortcut | Description | Available in |
|----|----|----|
| ⌘ + b (Mac) / Ctrl + b | Makes the selected text bold. | Text fields with the wiki toolbar. **Available in version 4.2 or higher.** |
| ⌘ + i (Mac) / Ctrl + i | Makes the selected text italic. | Text fields with the wiki toolbar. **Available in version 4.2 or higher.** |
| ⌘ + u (Mac) / Ctrl + u | Underlines the selected text. | Text fields with the wiki toolbar. **Available in version 4.2 or higher.** |
| ⌘ + Shift + p (Mac) / Ctrl + Shift + p | Toggles between the Edit and Preview tabs. | Text fields with the wiki toolbar and preview tabs. **Available in version 4.2 or higher.** |
| ⌘ + Return (Mac) / Ctrl + Enter | Submits the form. | When a textarea inside the form is focused. **Available in version 4.2 or higher.** |
| Tab / Shift + Tab | Indents or outdents the selected lines by two spaces. | When text is selected in a textarea using CommonMark Markdown formatting. **Available in version 7.0 or higher.** |
