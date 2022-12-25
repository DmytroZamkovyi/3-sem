{
    let swap_click = true;

    function swap_element(id1, id2) {
        let e1 = document.getElementById(id1);
        let e2 = document.getElementById(id2);

        let array1 = Array.from(e1.children);
        let array2 = Array.from(e2.children);

        array2.forEach(el => {
            e1.append(el); //if (el.tagName != "TEXTAREA")
        });

        array1.forEach(el => {
            e2.append(el); //if (el.tagName != "TEXTAREA")
        });

        // if (!swap_click == true) {
        //     elem1.style.gridTemplateColumns = "1fr 1fr 1fr 2fr";
        //     elem2.style.gridTemplateColumns = "1fr 2fr";
        // } else {
        //     elem1.style.gridTemplateColumns = "2fr 1fr";
        //     elem2.style.gridTemplateColumns = "2fr 1fr 1fr 1fr";
        // }

        elem1.append(arr1.pop());
    }
}

{
    function get_triangle_area(input_id1, input_id2, input_id3, output_id) {
        e1 = document.getElementById(input_id1);
        e2 = document.getElementById(input_id2);
        e3 = document.getElementById(input_id3);

        if (e1.value <= 0) {
            document.getElementById(input_id1).style.color = "#f00";
            alert("Перша сторона повинна бути додатною");
        } else {
            document.getElementById(input_id1).style.color = "#000";
            if (e2.value <= 0) {
                document.getElementById(input_id2).style.color = "#f00";
                alert("Друга сторона повинна бути додатною");
            } else {
                document.getElementById(input_id2).style.color = "#000";
                if (e3.value <= 0) {
                    document.getElementById(input_id3).style.color = "#f00";
                    alert("Друга сторона повинна бути додатною");
                } else {
                    document.getElementById(input_id3).style.color = "#000";
                    e_out = document.createElement("h4");
                    let a = e1.value * 1;
                    let b = e2.value * 1;
                    let c = e3.value * 1;
                    let p = (a + b + c) / 2;
                    e_out.innerHTML = "Площа трикутника: " + Math.sqrt(p*(p-a)*(p-b)*(p-c));
                    document.getElementById(output_id).append(e_out);
                }
            }
        }
    }
}

{
    window.addEventListener('load', e => {
        if (document.cookie != "") {
            if (confirm("Куки: " + document.cookie + "\nОчистити куки?")) {
                document.cookie = "max-element=; expires=Thu, 01 Jan 1970 00:00:00 GMT;";
                alert("Куки видалено");
                location.reload();
            }
        }
    });

    function find_max(class_name) {
        let elements = document.getElementsByClassName(class_name);
        let max = elements[0].value;
        for (let i = 1; i < elements.length; ++i) {
            if (elements[i].value > max) max = elements[i].value;
        }
        alert("Найбільший елемент: " + max);
        document.cookie = "max-element=" + max;
    }
}

{
    document.addEventListener("scroll", e => {
        let texts = document.getElementsByClassName("text-block-6");
        for (let i = 0; i < texts.length; ++i) {
            texts[i].style.fontWeight = localStorage.getItem("font-weight");
        }
    });

    function save_local_storage() {
        if (document.getElementById("rb1").checked) {
            localStorage.setItem("font-weight", "bold");
        } else {
            localStorage.setItem("font-weight", "normal");
        }
    }
}


{
    window.addEventListener('load', e => {
        alert("В попередній сесії було створено стільки елементів нумерованого списку: " + localStorage.getItem("li"));
    });

    let c = 0;
    function new_ln(id) {
        let li = document.createElement("li");
        document.getElementById(id).append(li);
        c = c + 1;
        localStorage.setItem("li", c);
    }

    function del_empty_ln(id) {
        console.log(111);
    }
}