<%@ include file="header.jsp" %>
<%@ include file="session_check.jsp" %>

<a href="/logout.jsp"><%=user_id%> Logout</a>

<h1> Schedule </h1>

<label for="search"> Search: </label>
<input type="text" name="search" id="search">
<br><br>

<table id="schetable" border="1" style="text-align:center">
    <thead>
        <td id>Code</td><td>Name</td><td>Start time</td><td>End time</td><td>Day of the Week</td>
    </thead>
    <tbody>
    </tbody>
</table>

<h1> Form </h1>
<label for="name"> Name </label>
<input type="text"  name="name"  id="name"><br>
<label for="start"> Start time </label>
<input type="number" name="start" id="start" min="0" max="23"> <br>
<label for="end"> End time </label>
<input type="number" name="end"  id="end" min="1" max="24"><br>
<label for="dow"> Day of the week </label>
<select name="dow" id="dow">
    <option value="Sun"> Sun </option>
    <option value="Mon"> Mon </option>
    <option value="Tue"> Tue </option>
    <option value="Wed"> Wed </option>
    <option value="Thu"> Thu </option>
    <option value="Fri"> Fri </option>
    <option value="Sat"> Sat </option>
</select> <br>
<button id="submit_btn">Submit</button>


<script>
    const schetable = $('#schetable');
    const searchInput = $('#search');

    function append_tr(obj) {
        const tbody = schetable.children('tbody');
        let tr = $('<tr>');

        for (const key of ['code', 'name', 'start', 'end', 'dow'])
        {
            let td = $('<td>');
    
            td.attr('code', obj['code']);
            td.text(obj[key]);

            if (key == 'code')
                td.click(del_func);

            tr.append(td);
        }
        tbody.append(tr);
    }

    function delete_tr(tr) {
        tr.remove();
    }

    function clear_table() {
        schetable.children('tbody').html('');
    }

    function del_func(event) {
        $.ajax({
            url: '/sche_delete.jsp',
            type: 'POST',
            data: {code: $(this).attr('code')},
            success: function(res){
                console.log("delete row")
            },
            error: function(){
                alert('error');
            }
        });
        $(this).parent().remove()
        console.log("done ajax delete")
    }

    function refresh_table() {
        $('tbody').children().remove()
    }
    $.ajax({
        url: '/sche_select.jsp',
        type: 'POST', 
        data: {"search": ""},
        success: function(res){
            var result = JSON.parse(res);
            for(var i= 0; i< result.length; i++){
                append_tr(result[i]); 
            }
        },
        error: function(){
            alert('error');
        }
    });
    searchInput.change(function(){
        console.log("The text has been changed.");
        $.ajax({
            url: '/sche_select.jsp',
            type: 'POST',
            data: {search: searchInput.val()},
            success: function(res){
                var result = JSON.parse(res);
                refresh_table();
                for(var i= 0; i< result.length; i++){
                    append_tr(result[i]); 
                }
            },
            error: function(){
                alert('error');
            }
        });
    });
    
    $('#submit_btn').click(function(){
        const formData= {}
        formData[name]= $('#name').val()
        formData[start]= $('#start').val()
        formData[end]= $('#end').val()
        formData[dow]= $('#dow').val()
        $.ajax({
            url: '/sche_insert.jsp',
            type: 'POST',
            data: {name: $('#name').val(), start: $('#start').val(), end: $('#end').val(), dow: $('#dow').val()},
            success: function(res){
                var result = JSON.parse(res);
                console.log(result[0].res)
                if (result[0].res === "t"){
                    append_tr(result[1])
                }
            },
            error: function(){
                alert('error');
            }
        });
        console.log("after sent")
    });

</script>
<%@ include file="footer.jsp" %>