import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["myCanvas"];

    imageObjects = [];
    imagesLoaded = false;
    capturer;

    
    connect() {
        console.log("Hello from animation controller js");
        const canvas = this.myCanvasTarget;
        const ctx = canvas.getContext('2d');
        const resultats = JSON.parse(this.element.dataset.animationResultatsValue);
        console.log(resultats);

        this.prepareAnimation(resultats, canvas, ctx)


        this.loadCCapture();

        const startAnimationBtn = document.getElementById("startAnimationBtn");
        startAnimationBtn.addEventListener("click", () => {
            this.reloadAnimation();
        });

        const recordAnimationBtn = document.getElementById("recordAnimationBtn");
        recordAnimationBtn.addEventListener("click", () => {
            this.recordAnimation();
        });
        
    }
    

    loadCCapture() {
        const script = document.createElement("script");
        script.src =
        "https://cdn.jsdelivr.net/npm/ccapture.js-npmfixed@1.1.0/build/CCapture.all.min.js";
        script.onload = () => {
        console.log("CCapture loaded.");
        };
        document.head.appendChild(script);
    } 

    prepareAnimation(resultats, canvas, ctx) {
        
        resultats.forEach((resultat, index) => {
            var equipe_id = resultat.equipe_id;
           
            // Replace this with the actual URL of the image for the corresponding equipe_id
            const logo_element_id = `logo-${equipe_id}`;
            const imageElement = document.getElementById(logo_element_id);
    
            // Check if the image element exists
            if (imageElement) {
                // Load the image for each equipe_id
                var img = new Image();
                img.src = imageElement.src; // Set the src to the URL of the image
                img.onload = () => {
                    this.imageObjects.push({ equipe_id, image: img });
                
                console.warn(`Image element with ID "${logo_element_id}" Found.`);

                // Show the image of equipe 1 in the middle of the canvas
                if (equipe_id === 2) {
                    ctx.drawImage(img, 10, 10, 200, 30);
                }


                };
            } else {
                console.warn(`Image element with ID "${logo_element_id}" Not found.`);
            }
        });
    }
    
    
    startAnimation(resultats, canvas, ctx) {
        
        var currentStep = 0;
        let currentFrame = 0;

        const animationSteps = 2;

        var frameDivider = 100;
        const longStepDuration = 100;
        const shortStepDuration = 30; 
        
        var capturer = this.capturer; // Assign capturer from the controller instance

        var totalPilotes = 20;
        var hauteurEquipeImage = 25;
        var widthPosition = 40;


        var positionStep1, positionStep2, positionStep3;
        var deltaQualifCourse;


        function drawAnimation(step, frame) {

            var imagesLoaded = false; 
            var imageObjects = []; 
    

                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.fillStyle = "white";
                ctx.fillRect(0, 0, canvas.width, canvas.height);
    
                var labelStep;
                var textContent = []; // Array to store the different texts for each step
                var posContent = []; // Array to store the different texts for each step
    
                resultats.forEach(function(resultat, index) {
                    const basePositionY = canvas.height - 20;
                    var positionY;
                    var labelStep;
                    var deltaYparPosition = 30;
    
                    var labelPilote = resultat.pilote;
                    var couleurEquipe = resultat.couleur;
    
                    var bgColor = 'black';
                    var textColor = 'white';

    
                    switch (step) {
                        case 0:  // Step 1: Position at the bottom of the canvas
                            frameDivider = shortStepDuration; 
    
                            bgColor = 'black';
                            textColor = 'white';
    
                            positionY = basePositionY;
                            labelStep = "début";
                            textContent.push(labelPilote + ' début' );
                            posContent.push( "" );
    
                            break;
                        case 1:   // Step 2: Move up based on the qualification value + 50
                            frameDivider = longStepDuration; 
    
                            positionY = basePositionY - ((deltaYparPosition * (totalPilotes - resultat.qualification)) * (frame / frameDivider));
                            labelStep = "qualification";
                            textContent.push(  labelPilote );
                            posContent.push(  resultat.qualification );
                        
                            break;
    
                    }
    
                    // Draw the step indicator text inside the canvas
                    ctx.fillStyle = "grey";
                    ctx.fillRect(5, 5, canvas.width - 10, 40);

                    ctx.fillStyle = "white";
                    ctx.font = "24px Arial";
                    var text = `Step ${step + 1} of ${animationSteps} ${labelStep}`;
                    var textWidth = ctx.measureText(text).width;
                    var x = (canvas.width - textWidth) / 2;
                    var y = 30;
                    ctx.fillText(text, x, y);


                // draw position pilote 
                var fontSize = 22;
                var fontFamily = 'Arial';
                ctx.font = fontSize + 'px ' + fontFamily;
                ctx.fillStyle = "black";

                var text = posContent[index];
                var textWidth = ctx.measureText(text).width;

                var centerX = 5 + (widthPosition - textWidth) / 2;
                ctx.fillText(text, centerX, positionY + 5, widthPosition, hauteurEquipeImage);



                ctx.fillText( textContent[index], 150, positionY + 2);

            

                const equipe1Image = this.imageObjects.find((obj) => obj.equipe_id === 2)?.image;
                if (equipe1Image) {
            
                    // Draw the equipe 1 image at the current position
                    ctx.drawImage(imageObjects[index].image, 10, 10, 200, 30);
                }


            });
        }

        

        function animationLoop() {
            drawAnimation(currentStep, currentFrame);
            
            if (capturer) {
                capturer.capture(canvas); // Capture frames here during the animation
            }

            currentFrame++;

            if (currentFrame > frameDivider) {
                currentStep++;
                currentFrame = 0;
            }

            if (currentStep >= animationSteps) {
                if (capturer) {
                    capturer.stop();
                    capturer.save();
                    capturer = null;
                }
                return;
            }

            requestAnimationFrame(animationLoop);
        }
        animationLoop();

    }


    recordAnimation() {

        console.log("call depuis bouton record");

        if (!this.capturer) {
            this.capturer = new CCapture({
                format: 'webm',
                quality: 100,
                framerate: 40,
                verbose: true,
                name: "video_if1"
            });
            this.capturer.start(); // Start recording
            console.log("Recording started.");
        } else {
            console.log("Recording is already in progress.");
        }
        
        // Start the animation, and the `animationLoop` will capture frames and save them
        this.reloadAnimation();
    }
    
    stopRecording() {
        if ( this.capturer) {
            this.capturer.stop();
            this.capturer.save();
            this.capturer = null;
        }
    }

    reloadAnimation(){
        console.log("call depuis bouton reload");
        const canvas = this.myCanvasTarget;
        const ctx = canvas.getContext('2d');
        const resultats = JSON.parse(this.element.dataset.animationResultatsValue);
        this.startAnimation(resultats, canvas, ctx);
    }




}

