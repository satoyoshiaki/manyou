20.times do
    Task.create(task_name: "aaa", description: "rrr", deadline: "2020-05-01", status: 0, priority: 1)
    end
    20.times do
    Task.create(task_name: "bbb", description: "rrr", deadline: "2020-05-05", status: 0, priority: 1)
    end

20.times do
    Task.create(task_name: "bbb", description: "rrr", deadline: "2020-05-05", status: 0, priority: 2)
    end