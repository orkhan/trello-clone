class Card < ApplicationRecord
  validates :title, presence: true
  
  belongs_to :list

  scope :newest, -> { order(created_at: :desc) }

  after_create :notify

  protected

    def notify
      resp = ApplicationController.new.render_to_string(
        :template => 'cards/show',
        :locals => { :@card => self }
      ).as_json
      ActionCable.server.broadcast "board_#{self.list.board.uid}", { action: "newCard", data: resp }
    end
end
