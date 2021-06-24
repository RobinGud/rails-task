console.log("custom js file loaded")

window.sizeHandler = () => {
    let a = document.getElementById("length").value
    let b = document.getElementById("width").value
    let c = document.getElementById("hiegth").value
    let volume = (a * b * c).toFixed(2)
    document.getElementById("volume").value = volume > 0 ? volume : 0.01
}