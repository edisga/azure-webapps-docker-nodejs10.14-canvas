const express = require("express")
const { CanvasRenderService } = require('chartjs-node-canvas')
const port = process.env.PORT || 3000;
let app = express()

app.get('/', async (req, res, next) => {
	try {
		const canvasRenderService = new CanvasRenderService(800, 800)
		const image = await canvasRenderService.renderToBuffer({
			type: 'bar',
			data: {
				labels: ['Red', 'Blue'],
				datasets: [{
					label: '# of Votes',
					data: [12, 19],
					backgroundColor: [
						'rgba(153, 102, 255, 0.2)',
						'rgba(255, 159, 64, 0.2)'
					]
				}]
			}
		});
		res.type('image/png')
		res.send(image)
	} catch (error) {
		res.send(error)
	}
});

app.listen(port, () => {
	console.log("Server running at port %d", port)
})
