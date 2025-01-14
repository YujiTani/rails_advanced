class AttachmentValidator < ActiveModel::EachValidator
  include ActiveSupport::NumberHelper

  def validate_each(record, attribute, value)
    return if value.blank? || !value.attached?

    has_error = false

    if options[:maximum]
      # ubyのオブジェクトが特定のクラスまたはそのサブクラスのインスタンスであるかどうかを確認するメソッド
      if value.is_a?(ActiveStorage::Attached::Many)
        value.each do |value_one|
          has_error = true unless validate_maximum(record, attribute, value_one)
        end
      else
        has_error = true unless validate_maximum(record, attribute, value)
      end
    end

    if options[:content_type]
      if value.is_a?(ActiveStorage::Attached::Many)
        value.each do |value_one|
          has_error = true unless validate_content_type(record, attribute, value_one)
        end
      else
        has_error = true unless validate_content_type(record, attribute, value)
      end
    end

    if options[:width]
      has_error = true unless validate_width(record, attribute, value)
    end

    record.send(attribute).purge if options[:purge] && has_error
  end

  private

  def validate_maximum(record, attribute, value)
    if value.byte_size > options[:maximum]
      record.errors[attribute] << (options[:message] || "は#{number_to_human_size(options[:maximum])}以下にしてください")
      false
    else
      true
    end
  end

  def validate_content_type(record, attribute, value)
    if value.content_type.match?(options[:content_type])
      true
    else
      record.errors[attribute] << (options[:message] || 'は対応できないファイル形式です')
      false
    end
  end

  def validate_width(record, attribute, value)
    width = extract_width(value)
    min_width = options[:width][:min] || 0
    max_width = options[:width][:max] || Float::INFINITY

    if width < min_width
      record.errors[attribute] << (options[:width][:message] || "横幅はは100以上の値にしてください")
      false
    elsif width > max_width
      record.errors[attribute] << (options[:width][:message] || "横幅はは700以下の値にしてください")
      false
    else
      true
    end
  end
end
