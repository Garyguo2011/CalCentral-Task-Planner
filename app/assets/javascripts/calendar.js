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
	
	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
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
			title:  task_string.substring(9, task_string.indexOf(",") - 1),
			start:  task_string.slice(task_string.indexOf("start") + 8, -3)
		};
		tasks_array_json.push(task);
	}

	$('#calendar').fullCalendar({
		header: {
			left: 'title',
			right: 'prev,next today,month,agendaWeek,agendaDay'
		},
		editable: true,
		droppable: true, // this allows things to be dropped onto the calendar !!!
		drop: function(date, allDay) { // this function is called when something is dropped
			// retrieve the dropped element's stored Event Object
			var originalEventObject = $(this).data('eventObject');
			
			// we need to copy it, so that multiple events don't have a reference to the same object
			var copiedEventObject = $.extend({}, originalEventObject);
			
			// assign it the date that was reported
			copiedEventObject.start = date;
			copiedEventObject.allDay = allDay;
			
			// render the event on the calendar
			// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
			$('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
			
			// is the "remove after drop" checkbox checked?
			if ($('#drop-remove').is(':checked')) {
				// if so, remove the element from the "Draggable Events" list
				$(this).remove();
			}
			
		},
		/* add tasks to event to be dropped on calendar */
		/* background color modified in assets/fullcalendar.print.css */
		events: tasks_array_json,
		editable: true,
	 	eventDrop: function(event, delta, revertFunc) {
    		var xml = new XMLHttpRequest();
			xml.open("GET", "calendar/?task=" + escape(event.title) + "&new_date=" + escape(event.start), true);
			xml.send();
		}

		
	});

	
});