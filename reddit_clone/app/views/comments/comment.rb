def child_comment_factory(comment)
    if !comment.child_comments.nil?
        <ul>
        comment.child_comments.each do |child_comment|
            <li>child_comment</li>
            child_comment_factory(child_comment)
        end
        </ul>
    end
end
 

<% def child_comment_factory(comment) %>
   <% if !comment.child_comments.nil? %>
        <ul>
        <% comment.child_comments.each do |child_comment| %>
            <li>child_comment</li>
            child_comment_factory(child_comment)
        end
        </ul>
    <% end %>
<% end %>

<ul>
<% @comments.each do |comment| %>
    <li>
        <a href="<%= comment_url(comment.id) %>"><%= comment.content %></a>
        <% if !comment.child_comments.nil? %>
        <ul>
            <% comment.child_comments.each do |child_comment| %>
            <li><a href="<%= comment_url(child_comment.id) %>"><%= child_comment.content %></a></li>
            <% end %>
        </ul>
        <% end %>
    </li>
<% end %>
</ul>



 

# N+1 version
 <ul>
<% comments.each do |comment| %>
    <li><%= comment.content %></li>
    <% if !comment.child_comments.empty? %>
        <%= render 'comments/comment', comments: comment.child_comments %>
    <% end %>
<% end %>
</ul>