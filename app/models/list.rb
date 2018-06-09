class List < ApplicationRecord
  validates :name, presence: true

  belongs_to :board
  has_many :cards, -> { newest }, dependent: :destroy

  scope :newest, -> { order(created_at: :desc) }

  after_create :notify

  protected

    def notify
      resp = ApplicationController.new.render_to_string(
        :template => 'lists/show',
        :locals => { :@list => self },
        :format => :json
      )
      ActionCable.server.broadcast "board_#{self.board.uid}", { action: "newList", data: resp }
    end
end
