class Word < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  belongs_to :category

  accepts_nested_attributes_for :answers,
    reject_if: lambda {|attributes| attributes[:content].blank?}

  validates :content, presence: true
  validate :valid_answer_numbers
  validate :check_correct_answer

  scope :sort, -> {order created_at: :desc}
  scope :order_by_content, -> {order :content}
  scope :find_all, -> {joins(:answers).where("is_correct = ?", true).
    select("words.content as word_content, answers.content as answer_content")}
  scope :search_words, ->(value){joins(:answers).
    where("words.content LIKE ? AND is_correct = ?", "%#{value}%", true).
    select("words.content as word_content, answers.content as answer_content")}

  class << self
    def search value
      if value.present?
        search_words value
      else
        find_all
      end
    end
  end

  private
  def valid_answer_numbers
    errors.add :answer, t("num_answers") if  answers.size < 2
  end

  def check_correct_answer
    correct_answer = answers.select {|answers| answers.is_correct?}
    errors.add :correct_answer,
      I18n.t("need_avaliable") if correct_answer.empty?
    errors.add :correct_answer,
      I18n.t("no_more_than_one") if correct_answer.size > 1
  end
end
