// bootstrap date timne picker function
function initBootstrapDateTimePicker(id,minView) {

    if (minView == 0) {
        format = 'yyyy-mm-dd hh:ii';
    }

    if (minView == 2) {
        format ='yyyy-mm-dd'
    }

    $("#"+id).datetimepicker({
        language: 'zh-CN',
        format: format,
        autoclose: true,
        minView: minView
    })
};

function initBootstrapDateRangePicker(id,time) {

    if (time) {
        format = 'YYYY-MM-DD HH:mm'
    } else {
        format = 'YYYY-MM-DD'
    }

    $("#"+id).daterangepicker({
        timePicker: time,
        timePicker24Hour: time,
        timePickerIncrement: 30,
        locale: {
            format: format
        }
    })
};

function initBootstrapTimePicker(id) {
    $("#"+id).timepicker({
        showInputs: false,
        showMeridian: false,
        showSeconds: true,
        minuteStep: 1
    });
}