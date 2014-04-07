ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    #    div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #      span :class => "blank_slate" do
    #        span "Welcome to Active Admin. This is the default dashboard page."
    #        small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
    #      end
    #    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  unless Period.actual_period.nil?
    columns do
      column do
        panel "Ausencias de la semana" do
          table_for Log.where('day >= ? and day <= ? and status = ?', Date.today.beginning_of_week, Date.today.end_of_week, "Absent") do |t|
            t.column("Turno") { |log| link_to log.shift, admin_log_path(log) }
            t.column("Primo") { |log| log.employee }
            t.column("Fecha") { |log| log.day }
          end
        end
      end
      column do
        panel "Ranking de ausencias" do
          table_for Log.select("employee, count(employee) as cantidad").group(:employee).where('period = ? and status = ?', Period.actual_period.name, "Absent").order("cantidad desc") do |t|
            t.column("Primo") { |log| log.employee }
            t.column("Cantidad") { |log| log.cantidad }
          end
        end
      end
    end

    columns do
      column do
        panel "Atrasos de la semana" do
          table_for Log.where('day >= ? and day <= ? and status = ?', Date.today.beginning_of_week, Date.today.end_of_week, "Late") do |t|
            t.column("Turno") { |log| link_to log.shift, admin_log_path(log) }
            t.column("Primo") { |log| log.employee }
            t.column("Fecha") { |log| log.day }
          end
        end
      end
      column do
        panel "Ranking de atrasos" do
          table_for Log.select("employee, count(employee) as cantidad").group(:employee).where('period = ? and status = ?', Period.actual_period.name, "Late").order("cantidad desc") do |t|
            t.column("Primo") { |log| log.employee }
            t.column("Cantidad") { |log| log.cantidad }
          end
        end
      end
    end
  end #unless
  end # content


end
