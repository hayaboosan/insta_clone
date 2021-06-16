class MessageDecorator < ApplicationDecorator
  delegate_all
  def created_at
    helpers.tag.span(class: 'time') do
      object.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
  end
end
