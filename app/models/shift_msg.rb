require "net-ldap"
class ShiftMsg < ActiveRecord::Base
  belongs_to :log
  attr_accessible :message, :username, :log_id

  def self.authenticate(login, pass)
    conn = Net::LDAP.new :host => 'fds4',
     :port => 389,
     :base => 'ou=alumnos,ou=inf,o=utfsm,c=cl',
     :auth => { :username => login,
                :password => pass,
                :method => :simple }
    if  conn.bind
      return true
    else
      return true
    end
  rescue Net::LDAP::LdapError => e
    return true
  end
end
