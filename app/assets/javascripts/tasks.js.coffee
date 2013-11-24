# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#tasks =
#    append: (task) -> $(".tasks").append('<div class="task">'+task.body +'</div>')
# $("#text").val()

tasks =
    task_list: []
    get_tasks: () ->
            $.ajax '/tasks',
            type: 'GET'
            dataType: 'json'
            error: (jqXHR, textStatus, errorThrown) ->
                #$('body').append "AJAX Error: #{textStatus}"
            success: (data, textStatus, jqXHR) ->
                #$('body').append "Successful AJAX call"
                tasks.task_list = data
                tasks.update_ui()
                
    update_ui: () -> 
            $(".task").remove()
            $(".tasks").append('<tr class="task"><td>'+task.body+'</td><td><a href="#" class="delete_button" task_id="'+task.id+'">Delete</a></td></tr>') for task in @task_list
            $(".delete_button").each ->
                $(this).click -> 
                    (tasks.delete_task $(this).attr("task_id"))
                    false
            
    add_task: () ->
            $.ajax '/tasks/add',
            type: 'GET'
            dataType: 'json'
            data: {task: {body: $("#text").val(), done: false}}
            error: (jqXHR, textStatus, errorThrown) ->
                #$('body').append "AJAX Error: #{textStatus}"
            success: (data, textStatus, jqXHR) ->
                #$('body').append "Successful AJAX call"
                tasks.task_list = data
                tasks.update_ui()
    
    delete_task: (id) ->
            $.ajax '/tasks/delete/'+id,
            type: 'GET'
            dataType: 'json'
            error: (jqXHR, textStatus, errorThrown) ->
                #$('body').append "AJAX Error: #{textStatus}"
            success: (data, textStatus, jqXHR) ->
                #$('body').append "Successful AJAX call"
                tasks.task_list = data
                tasks.update_ui()
    
    
jQuery ->
	$(".add_button").click ->  
        tasks.add_task()
        false
    tasks.get_tasks()