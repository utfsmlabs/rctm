# encoding: utf-8
class CheckinsController < ApplicationController
  def index
    @P = Period.actual_period
    unless @P.nil?
      @D =  I18n.localize(Date.today, :format => '%A') #weekday
      @B = Block.all
      b = nil
      require 'tod'
      @B.each do |bl|
          if TimeOfDay.parse(bl.start_at) -900 < Time.now.to_time_of_day and TimeOfDay.parse(bl.end_at) > Time.now.to_time_of_day
              b = bl
          end
      end
      unless b.nil?
          @S = Shift.where(:weekday=>@D,:block_id=>b)
          unless @S.empty?
              @checkins = Checkin.where(:period_id=>@P,:shift_id=>@S.first.id)
              @logs = Log.where(:day=>Date.today,:shift=>@S.first.name)
              unless @checkins.empty?

              else
                flash[:notice] = "De momento no hay turnos" + Time.now.to_s  
              end
          else
              flash[:notice] = "No hay turnos en esta hora"
          end
      else
          flash[:notice] = "Fuera del horario de turnos"
      end
    else
        flash[:notice] = "Fuera del horario de semestre"
    end
  end



  def create
    @C = Checkin.find(params[:id])
    @log = Log.where(:day=>Date.today,:shift=>@C.shift.name,:employee=>@C.employee.name)
    if @log.empty?
      @L = Log.new(:period=>Period.actual_period.name,:status=>@C.status,:shift=>@C.shift.name,:employee=>@C.employee.name,:day=>Date.today,:time=>Time.now.to_time_of_day.to_s)
      @L.save()
    end
    redirect_to :action => "index"
  end

  def log
    @shift_msg = ShiftMsg.new
    @Period = Period.actual_period
    if @Period.nil?
      @Period = Period.last
      if @Period.nil?
        flash[:notice] = 'No existen periodos.'
        redirect_to :action => "index"
      end
    end
    @logs = Log.search(params[:search]).where("day < '#{@Period.end_at}'").where("day > '#{@Period.beginning}'").order("day DESC,time ASC").paginate(:per_page=>8,:page => params[:page])
    @employees = []
    for r in Employee.all do
      @employees << r.name
    end
  end

  def absences
    Log.absences()
    redirect_to log_path
  end

  def schedule
    @Period = Period.actual_period
    unless @Period.nil?
      @checkins = Checkin.where(:period_id=>@Period).joins(:shift).order(:block_id)
      unless @checkins.empty?
        @blocks = Block.all
        @shifts = Shift.all
      else
        flash[:notice] = "No hay horarios asignados"     
      end
    else
      flash[:notice] = "No hay semestre agendado"
    end
  end

  def time
    render :text => DateTime.now.to_s
  end

  def shiftmessage
    @shiftmsg = ShiftMsg.new(params[:shift_msg])
    if ShiftMsg.authenticate(@shiftmsg.username,params[:password])
      if @shiftmsg.save
        flash[:notice] = 'Mensaje almacenado exitosamente.'
        redirect_to "/log"
      else
        flash[:notice] = 'Error al almacenar el mensaje'
        redirect_to "/log"
      end
    else
      flash[:notice] = 'Usuario/Clave INF Incorrectos'
      redirect_to "/log"
    end
  end

  def showmessage
    @shiftmessage = ShiftMsg.find(params[:idmsg])
    respond_to do |format|
      format.html { redirect_to :action => "log" }
      format.js
    end
  end

  def primosdeturno
    @P = Period.actual_period
    unless @P.nil?
      @D =  I18n.localize(Date.today, :format => '%A') #weekday
      @B = Block.all
      b = nil
      require 'tod'
      @B.each do |bl|
          if TimeOfDay.parse(bl.start_at) -900 < Time.now.to_time_of_day and TimeOfDay.parse(bl.end_at) > Time.now.to_time_of_day
              b = bl
          end
      end
      unless b.nil?
          @S = Shift.where(:weekday=>@D,:block_id=>b)
          unless @S.empty?
              @checkins = Checkin.where(:period_id=>@P,:shift_id=>@S.first.id)
              @logs = Log.where(:day=>Date.today,:shift=>@S.first.name)
              unless @checkins.empty?
		@pdts = @checkins.map { |f| f.employee.name }.join ','
		render :text => @pdts	
              else
                render :text => "De momento no hay turnos"   
              end
          else
              render :text => "No hay turnos en esta hora"
          end
      else
          render :text => "Fuera del horario de turnos"
      end
    else
        render :text => "Fuera del horario de semestre"
    end
  end

end
