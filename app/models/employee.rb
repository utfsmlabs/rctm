class Employee < ActiveRecord::Base
  attr_accessible :name


  def self.deudas_desde(str)
    resultado = []
    start = Date.parse(str)
    atrasos = Log.where(:day=>start..Date.today()).where(:status=>"Late")
    faltas = Log.where(:day=>start..Date.today()).where(:status=>"Absent")
    p = Period.last
    e = Employee.all()
    e.each do |emp|
      fs = faltas.where(:employee=>emp.name)
      tot_faltas = fs.count
      at = atrasos.where(:employee=>emp.name)
      tot_atrasos = at.count
      tot_msj_f=0
      fs.each do |f|
        unless f.shift_msg.nil?
          tot_msj_f += 1
        end
      end
      tot_msj_a=0
      at.each do |a|
        unless a.shift_msg.nil?
          tot_msj_a +=1
        end
      end
      resultado << emp.name + ": Atrasos = " + tot_atrasos.to_s + " (" + tot_msj_a.to_s + " con mensajes), Faltas = " + tot_faltas.to_s + " (" + tot_msj_f.to_s + " con mensajes)"
    end    
    return resultado
  end

end
