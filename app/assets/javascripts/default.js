$(document).ready(function(){

$("#end_date").change(function(){
    var storyId = $("#dowload_report").attr("href")+"?start_date="+$("#start_date").val()+"&end_date="+$("#end_date").val();
	$("#dowload_report").prop('href',storyId);	
	$("#dowload_report").show();
});

$("#start_date").change(function(){
    var storyId = $("#dowload_report").attr("href")+"?start_date="+$("#start_date").val()+"&end_date="+$("#end_date").val();
	$("#dowload_report").prop('href',storyId);	
	$("#dowload_report").show();
});




// $("#end_date").change(function(){
//     var storyId = $("#dowload_report_csv").attr("href")+"?start_date="+$("#start_date").val()+"&end_date="+$("#end_date").val();
// 	$("#dowload_report_csv").prop('href',storyId);	
// 	$("#dowload_report_csv").show();
// });


});