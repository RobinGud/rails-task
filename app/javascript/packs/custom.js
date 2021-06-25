window.sizeHandler = () => {
    const a = document.getElementById("length").value
    const b = document.getElementById("width").value
    const c = document.getElementById("hiegth").value
    const volume = (a * b * c).toFixed(2)
    document.getElementById("volume").value = volume > 0 ? volume : 0.01
    getPrice()
}

window.getDistance = () => {
    const from_id = document.getElementById("from_city_id").value
    const to_id = document.getElementById("to_city_id").value

    if (from_id && to_id && from_id != to_id) {
        const url = `${window.location.href}distance/?from_id=${from_id}&to_id=${to_id}`
        fetch(url, {
            "method": "GET"
        })
        .then(res => {
            return res.text()
         })
         .then(response => {
             document.getElementById("distance_value").innerHTML = `${JSON.parse(response).distance} KM`
             getPrice()
         })
        .catch(err => {
            console.error(err);
        });
    }
}

window.getPrice = () => {
    const distance = parseFloat(document.getElementById("distance_value").innerHTML)
    const volume = parseFloat(document.getElementById("volume").value)
    const weight = parseFloat(document.getElementById("weight").value)

    const price = (500 + (distance * (volume + weight))).toFixed(2)

    if (distance) {
        document.getElementById("price_value").innerHTML = `${price} $`
    }
}