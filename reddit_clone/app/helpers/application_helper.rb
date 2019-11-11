module ApplicationHelper
    def auth_token
        <<-HTML.html_safe
            <input type="hidden" name="authenticity_token"
                value="#{ form_authenticity_token }" />
        HTML
    end

    def child_comment_factory(comment)
        <<-HTML.html_safe
            <% if !comment.child_comments.nil? %>
                <ul>
                <% comment.child_comments.each do |child_comment| %>
                    <li><%= child_comment %></li>
                    <% child_comment_factory(child_comment) %>
                <% end %>
                </ul>
            <% end %>
        HTML
        
        # if !comment.child_comments.nil?
        #     "<ul>".html_safe
        #     comment.child_comments.each do |child_comment|
        #         "<li>child_comment</li>".html_safe
        #         child_comment_factory(child_comment)
        #     end
        #     "</ul>".html_safe
        # end
    end
    
end
