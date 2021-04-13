# frozen_string_literal: true

namespace :table_excel do
  desc "active_record`s way"
  task rails_export_table_excel: :environment do
    Spreadsheet.client_encoding = "UTF-8"
    bold_weight = Spreadsheet::Format.new(weight: :bold, size: 10, color: :black, vertical_align: :middle, align: :center, border: :medium)
    content_format = Spreadsheet::Format.new(size: 10, color: :black, vertical_align: :middle, border: :thin)
    book = Spreadsheet::Workbook.new
    ActiveRecord::Base.connection.tables.each do |table_name|
      sheet = book.create_worksheet name: table_name
      sheet.insert_row(0, ["表名"])
      sheet.insert_row(1, ["表技术名", table_name])
      sheet.insert_row(2, ["描述"])
      sheet.insert_row(3, ["限制"])
      sheet.insert_row(4, [""])
      sheet.insert_row(5, [""])
      sheet.insert_row(6, ["字段", "字段名", "字段类型", "长度", "小数位", "是否必输", "默认值", "备注"])
      sheet.column(0).width = 22.75
      sheet.column(1).width = 25
      sheet.column(7).width = 32
      (0..3).each do |i|
        sheet.row(i).set_format(0, bold_weight)
        (1..12).each do |j|
          sheet.row(i).set_format(j, content_format)
        end
        # 合并
        sheet.merge_cells(i, 1, i, 12)
      end
      (0..7).each do |j|
        sheet.row(6).set_format(j, bold_weight)
      end
      ActiveRecord::Base.connection.columns(table_name).each_with_index do |c, index|
        decimal_length = 0
        column_length = 0
        # 类型
        data_type = c.type.to_s
        if data_type == "integer"
          column_length = c.precision
        elsif data_type == "decimal"
          column_length = c.precision
          decimal_length = c.scale
        end
        # 默认值
        default = c.default
        # 是否必输
        must = !c.null
        item = {column_name: c.name, meaning: "", data_type: data_type, column_length: column_length, decimal_length: decimal_length, is_must: must, default_value: default, comments: ""}
        sheet.insert_row(index + 7, [item[:column_name], item[:meaning], item[:data_type], item[:column_length], item[:decimal_length], item[:is_must], item[:default_value], item[:comments]])
        (0..7).each do |j|
          sheet.row(index + 7).set_format(j, content_format)
        end
      end
      (0..sheet.row_count).each do |i|
        sheet.row(i).height = 18
      end
      puts table_name
    end

    file_name = "数据字典.xls"
    book.write "#{Rails.root}/public/#{file_name}"
  rescue => e
    puts e.message
  end

  desc "ruby`s way mysql"
  task ruby_export_table_excel: :environment do
    @client = Mysql2::Client.new(host: "localhost", username: "root", password: "root")
    @client.query("use 数据库名称")
    tables = @client.query("show tables").to_a.map { |table| table["Tables_in_master"] }

    Spreadsheet.client_encoding = "UTF-8"
    bold_weight = Spreadsheet::Format.new(weight: :bold, size: 10, color: :black, vertical_align: :middle, align: :center, border: :medium)
    content_format = Spreadsheet::Format.new(size: 10, color: :black, vertical_align: :middle, border: :thin)
    book = Spreadsheet::Workbook.new
    tables.each do |table_name|
      tcs = @client.query("DESCRIBE  #{table_name}").to_a

      sheet = book.create_worksheet name: table_name
      sheet.insert_row(0, ["表名"])
      sheet.insert_row(1, ["表技术名", table_name])
      sheet.insert_row(2, ["描述"])
      sheet.insert_row(3, ["限制"])
      sheet.insert_row(4, [""])
      sheet.insert_row(5, [""])
      sheet.insert_row(6, ["字段", "字段名", "字段类型", "长度", "小数位", "是否必输", "默认值", "备注"])
      sheet.column(0).width = 22.75
      sheet.column(1).width = 25
      sheet.column(7).width = 32
      (0..3).each do |i|
        sheet.row(i).set_format(0, bold_weight)
        (1..12).each do |j|
          sheet.row(i).set_format(j, content_format)
        end
        sheet.merge_cells(i, 1, i, 12)
      end
      (0..7).each do |j|
        sheet.row(6).set_format(j, bold_weight)
      end
      tcs.each_with_index do |c, index|
        decimal_length = 0
        column_length = 0
        data_type = c["Type"].gsub(/\(.*\)/, "")
        if c["Type"] =~ /^varchar/ || c["Type"] =~ /^int/
          column_length = c["Type"].gsub(/[^\d]/, "")
        elsif /^decimal/.match?(c["Type"])
          /\((..),(.)\)/ =~ c[1]
          column_length = $1
          decimal_length = $2
        end
        is_must = c["Null"].eql?("NO") ? "1" : "0"
        item = {column_name: c["Field"], meaning: "", data_type: data_type, column_length: column_length, decimal_length: decimal_length, is_must: is_must, default_value: c["Default"], comments: ""}
        sheet.insert_row(index + 7, [item[:column_name], item[:meaning], item[:data_type], item[:column_length], item[:decimal_length], item[:is_must], item[:default_value], item[:comments]])
        (0..7).each do |j|
          sheet.row(index + 7).set_format(j, content_format)
        end
      end

      (0..sheet.row_count).each do |i|
        sheet.row(i).height = 18
      end
    end
    file_name = "数据字典.xls"
    book.write "#{Rails.root}/public/#{file_name}"
  rescue => e
    puts e.message
  end
end
