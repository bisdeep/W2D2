require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize (name, funding, salaries)
        #salaries = 'title => salary'
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    # def name
    #     @name
    # end

    # def funding
    #     @funding
    # end

    def valid_title?(title)
        @salaries.has_key?(title)
    end

    def >(other_startup)
        self.funding > other_startup.funding
    end

    def hire(employee_name, title)
        if self.valid_title?(title)
            @employees << Employee.new(employee_name, title)
        else #raise an error
            raise "title is invalid!"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        wage = @salaries[employee.title]
        #match the emplyees pay as listed in the hash
        if @funding >= wage
            employee.pay(wage)
            @funding -= wage #deduct from funding after paying empl
        else raise "not enough funding"
        end
    end
    
    def payday #pay all employees
        @employees.each do |employee|
            self.pay_employee(employee)
        end
    end

    def average_salary
        sum = 0
        @employees.each do |employee|
            sum += @salaries[employee.title]
        end

        sum.to_f / (@employees.length)
    end

    def close
        @employees = [] #drop emplyees
        @funding = 0 #empty funding
    end

    def acquire(startup) #startup we pass in is the former.
        @funding += startup.funding
        #hire the employees fro the prev startup
        #put them in the salaries hash
        startup.salaries.each do |title, amount|
            if !@salaries.has_key?(title)
                @salaries[title] = amount
            end
        end
        @employees += startup.employees

        #close former startup
        startup.close()


    end
end
