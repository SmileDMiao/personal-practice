# frozen_string_literal: true

require "active_record"

module ActiveRecord
  class Base
    # fields = %w(name email city created_at updated_at)
    # rows = [
    #     ["smile", '2268571581@qq.com', 'shanghai', '2016-01-01', '2016-01-01'],
    #     ['malzahar', 'm8023zsm@live.com', 'beijing', '2016-01-01', '2016-01-01'],
    # ]
    # BulkUpsert.bulk_write(fields, rows, :conflict => [:name])
    # conflict: uniq index columns
    # update: if conflict update columns

    def self.bulk_write_pg(fields, rows, upsert = nil)
      return 0 if rows.empty?
      rows = rows.map do |row|
        values = row.map do |val|
          connection.quote(val)
        end.join ", "
        "(#{values})"
      end
      field_list = fields.map { |e| %("#{e}") }.join ", "

      sql = "INSERT INTO #{table_name} (#{field_list}) VALUES #{rows.join ", "}"
      if upsert
        update = if !upsert[:update]
          fields.map(&:to_s) - upsert[:conflict].map(&:to_s)
        else
          upsert[:update]
        end
        update = update.map { |field| "#{field} = EXCLUDED.#{field}" }

        sql += " ON CONFLICT (#{upsert[:conflict].join ", "}) DO UPDATE SET #{update.join ", "}"
        if upsert[:where]
          sql += " WHERE #{upsert[:where]}"
        end
      end
      res = connection.execute(sql)
      res.cmd_tuples
    end

    # fields = %w(name email city created_at updated_at)
    # rows = [
    #     ["smile", '2268571581@qq.com', 'shanghai', '2016-01-01', '2016-01-01'],
    #     ['malzahar', 'm8023zsm@live.com', 'beijing', '2016-01-01', '2016-01-01'],
    # ]

    def self.bulk_write_mysql(fields, rows, upsert = nil)
      return 0 if rows.empty?
      rows = rows.map do |row|
        values = row.map do |val|
          connection.quote(val)
        end.join ", "
        "(#{values})"
      end
      field_list = fields.join ", "

      sql = "INSERT INTO #{table_name} (#{field_list}) VALUES #{rows.join ", "}"
      if upsert
        update = if !upsert[:update]
          fields.map(&:to_s) - upsert[:conflict].map(&:to_s)
        else
          upsert[:update]
        end
        update = update.map { |field| "#{field} = VALUES(#{field})" }

        sql += " ON DUPLICATE KEY UPDATE #{update.join ", "}"
        if upsert[:where]
          sql += " WHERE #{upsert[:where]}"
        end
      end
      connection.execute(sql)
    end
  end
end
