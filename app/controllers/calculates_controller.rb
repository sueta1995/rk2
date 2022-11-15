# frozen_string_literal: true

# controller class
class CalculatesController < ApplicationController
  before_action :set_input, only: [:create]
  before_action :valid?, only: [:create]

  def new; end

  def create
    @input_arr = @input.split(' ').collect(&:to_f)
    @result_arr = []

    calculting
  end

  private

  def set_input
    @input = params[:numbers]
  end

  def valid?
    temp = checking

    return if base_case(temp)
    return if empty_case
    return if specific_case
  end

  def checking
    result = nil
    index = 0

    @input.split('').each_index do |i|
      unless @input[i] =~ /[-0-9. ]/
        (result = @input[i]
         index = i)
      end
    end

    { result:, index: }
  end

  def base_case(temp)
    return if temp[:result].nil?

    redirect_to(root_path,
                notice: "Найден посторонний символ на #{temp[:index] + 1} месте: #{temp[:result]}."); true
  end

  def empty_case
    return unless @input.split(' ').empty?

    redirect_to(root_path, notice: 'Введите непустую строку.')
    true
  end

  def specific_case
    @input.split(' ').each do |x|
      x = x.to_f.to_s if x.to_i.to_f.to_s == x.to_f.to_s
      next unless x != x.to_f.to_s

      redirect_to(root_path, notice: 'Обнаружены посторонние символы: лишние нули, точки или минус.')

      return true
    end
  end

  def calculting
    pos_c = @input_arr.select(&:positive?).length
    neg_c = @input_arr.select(&:negative?).length
    attitude = pos_c.positive? ? neg_c.to_f / pos_c : 0

    changing(attitude, pos_c)
  end

  def changing(attitude, pos_c)
    completed = false

    @input_arr.length.times do |x|
      if @input_arr[x].positive? && !completed
        @result_arr << attitude
        completed = true
      end
      @result_arr << @input_arr[x]
    end

    @result_arr << 0 if pos_c.zero?
  end
end
