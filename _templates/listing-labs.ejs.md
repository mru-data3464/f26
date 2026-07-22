```{=html}
<%
function formatDueDate(due) {
  if (!due) return '';

  const parsedDue = new Date(due);
  if (Number.isNaN(parsedDue.getTime())) return due;

  return parsedDue.toLocaleDateString('en-US', {
    month: 'short',
    day: 'numeric',
    year: 'numeric'
  });
}

items = (items || []).filter((item) => {
  const pathBase = item.path.split('/').pop();
  return pathBase !== 'index.qmd' && !item.draft;
});
%>

<% if (items.length > 0) { %>
<table>
  <thead>
    <tr>
      <th>Date</th>
      <th>Title</th>
      <th>Due</th>
    </tr>
  </thead>
  <tbody>

<% for (const item of items) { %>
    <tr>
      <td><%= item.date || '' %></td>
      <td><a href="<%- item.path %>"><%= item.title %></a></td>
      <td><%= formatDueDate(item.due) %></td>
    </tr>
<% } %>
  </tbody>
</table>
<% } %>
```