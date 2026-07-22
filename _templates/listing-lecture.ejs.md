```{=html}
<table>
  <thead>
    <tr>
      <th>Date</th>
      <th>Title</th>
      <th>Slides</th>
      <th>Demo Code</th>
      <th>Progress</th>
    </tr>
  </thead>
  <tbody>

<%
items = (items || []).filter((item) => {
  const pathBase = item.path.split('/').pop();
  return pathBase !== 'index.qmd' && !item.draft;
});
%>

<% if (items.length > 0) { %>
<% for (const item of items) {
    const stem = item.path.split('/').pop().replace(/\.qmd$/, '');
    const slidePdfPath = `../slides/${stem}.pdf`;
    const slideHtmlPath = `../slides/${stem}.html`;
    const demoCodePath = item["demo-code"];
    const demoDataPath = item["demo-data"];
%>
      <tr>
        <td><%= item.date || '' %></td>
        <td><a href="<%- item.path %>"><%= item.title %></a></td>
        <td>
          <a href="<%- slidePdfPath %>" title="PDF slides" aria-label="PDF slides for <%= item.title %>"><img src="../img/file-pdf.svg" alt="PDF slides" width="24"></a>
          <a href="<%- slideHtmlPath %>" title="HTML slides" aria-label="HTML slides for <%= item.title %>"><img src="../img/file-slides.svg" alt="HTML slides" width="24"></a>
        </td>
        <td>
  <%   if (demoCodePath) { %>
          <a href="<%- demoCodePath %>" title="Demo notebook" aria-label="Demo notebook for <%= item.title %>" download><img src="../img/journal-code.svg" alt="Demo notebook" width="24"></a>
  <%   }
      if (demoDataPath) { %>
          <a href="<%- demoDataPath %>" title="Demo data" aria-label="Demo data for <%= item.title %>" download><img src="../img/filetype-csv.svg" alt="Demo data" width="24"></a>
  <%   } %>
        </td>
        <td><%= item.leftoff %></td>
      </tr>
  <% } %>
    </tbody>
  </table>
<% } %>
```
