$(document).ready(function(){

    $('#external-events div.external-event').each(function() {

        // it doesn't need to have a start or end
        var eventObject = {
            title: $.trim($(this).text()) // use the element's text as the event title
        };
        
        // store the Event Object in the DOM element so we can get to it later
        $(this).data('eventObject', eventObject);
        
        // make the event draggable using jQuery UI
        $(this).draggable({
            zIndex: 999,
            revert: true,      // will cause the event to go back to its
            revertDuration: 0  //  original position after the drag
        });
        
    });
    
    /* 
        get all tasks from view, important: complicated array type, so can't convert to js array automatically 
        it's converted to a long string
     */
    if ($('#all_tasks').val() == undefined) {
        return ;
    }

    var all_tasks_string_array = $('#all_tasks').val().split('{');
    var tasks_array_json = new Array();

    for(var i = 1; i < all_tasks_string_array.length; i++){
        task_string = all_tasks_string_array[i];
        var task = {
            /* string process to extract info from the long string */
            title:  "",
            start:  task_string.slice(task_string.indexOf("start") + 8, -3)
        };
        tasks_array_json.push(task);
    }

    $('#calendar_dashboard').fullCalendar({
        header: {
            left: 'nil',
            right: 'prev,next today,month,agendaWeek,agendaDay'
        },
        height: 300,
        
        events: tasks_array_json        
    });

    
});