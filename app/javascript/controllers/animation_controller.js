import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["myCanvas"];

    capturer;

    connect() {
       // console.log("Hello from animation controller js");

        this.loadCCapture();
        this.reloadAnimation();

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
        script.src = "https://cdn.jsdelivr.net/npm/ccapture.js-npmfixed@1.1.0/build/CCapture.all.min.js";
        script.onload = () => {
            console.log("CCapture loaded.");
        };
        document.head.appendChild(script);
    } 
    
    startAnimation(resultats, canvas, ctx, infosEventValue) {

       // console.log(resultats);
        
        var currentStep = 0;
        var currentFrame = 0;

        const animationSteps = 7;

        var frameDivider = 80;
        const longStepDuration = 80;
        const shortStepDuration = 40; 
        
        var capturer = this.capturer; // Assign capturer from the controller instance

        var totalPilotes = 20;
        var hauteurEquipeImage = 25;
        var widthPosition = 40;
        const sizeMtDotd = 25;

        const margeX = 30;
        const imgWidth = canvas.width - widthPosition * 2 - margeX * 2 - 10;
        const imgHeight = hauteurEquipeImage;

        var positionStep1, positionStep2, positionStep3;
        var deltaQualifCourse;
        var borderRadius = 5;

        function easeInOutCubic(t) {
            return t < 0.5 ? 4 * t * t * t : (t - 1) * (2 * t - 2) * (2 * t - 2) + 1;
        }

        function drawRoundedRect(ctx, x, y, width, height, borderRadius) {

            ctx.beginPath();
            ctx.moveTo(x + borderRadius, y);
            ctx.lineTo(x + width - borderRadius, y);
            ctx.arc(x + width - borderRadius, y + borderRadius, borderRadius, 1.5 * Math.PI, 2 * Math.PI);
            ctx.lineTo(x + width, y + height - borderRadius);
            ctx.arc(x + width - borderRadius, y + height - borderRadius, borderRadius, 0, 0.5 * Math.PI);
            ctx.lineTo(x + borderRadius, y + height);
            ctx.arc(x + borderRadius, y + height - borderRadius, borderRadius, 0.5 * Math.PI, Math.PI);
            ctx.lineTo(x, y + borderRadius);
            ctx.arc(x + borderRadius, y + borderRadius, borderRadius, Math.PI, 1.5 * Math.PI);
            ctx.closePath();
            ctx.fill();
        }

        var imageObjects = []; 

        var deltaYparPosition = 30;

        var positionY;
        var labelStep;
        var bgColor = 'black';
        var textColor = 'white';
9
        const basePositionY = canvas.height - 60;

        var background = null;

        function drawAnimation(step, frame) {

            ctx.clearRect(0, 0, canvas.width, canvas.height);

            if (!background) {
                console.log('set background')
                const backgroundImage = new Image();
                backgroundImage.src = "/images/bg_grey.jpg";
            
                backgroundImage.onload = function() {
                  ctx.drawImage(backgroundImage, 0, 0, canvas.width, canvas.height);
                  // Store the canvas data (background image) using getImageData()
                  background = ctx.getImageData(0, 0, canvas.width, canvas.height);
                  // Now call drawAnimation again to continue the animation
                  drawAnimation(step, frame);
                };
            } else {
          //      console.log('put background')

                // If the background image is already stored, restore it using putImageData()
                ctx.putImageData(background, 0, 0);
            }
                
                var posContent = []; 
                var textContent = []; 
                var scoreContent = []; 

                var mtContent, dotdContent;

                var movementRange = -10; 
                var totalSteps = frameDivider; 
                var movementStep = frame % totalSteps; 

                // Create image objects
                const imageMT = new Image();
                imageMT.src = "/images/mt_violet.png";
            //    console.log("load image mt");

                const imageDOTD = new Image();
                imageDOTD.src = "/images/dotd_gold.png";
            //    console.log("load image dotd");

            resultats.forEach(function(resultat, index) {
                
            //    console.log(resultats);
                var labelPilote = resultat.pilote;
                var equipe_id = resultat.equipe_id;

                const banniere_element_id = `banniere-${equipe_id}`;
                const imageElement = document.getElementById(banniere_element_id);
                const image = new Image();

                image.src = imageElement.src;
        
                imageObjects.push({
                    image: image,
                    positionY: 0
                });

                switch (step) {
                    case 0:  // Step 1: Position at the bottom of the canvas
                        frameDivider = shortStepDuration; 
                        bgColor = 'black';
                        textColor = 'white';
                        positionY = basePositionY;
                        labelStep = "début";
                        textContent.push(labelPilote  );
                        posContent.push( "" );
                        break;

                    case 1:   // Step 2: Move up based on the qualification value + 50
                        frameDivider = longStepDuration; 
                        positionY = basePositionY - ((deltaYparPosition * (totalPilotes - resultat.qualification)) * (frame / frameDivider));
                        labelStep = "qualification";
                        textContent.push( labelPilote );
                        posContent.push( resultat.qualification );

                        break;
                
                    case 2: // hold positions
                        frameDivider = shortStepDuration; 
                        positionStep1 = basePositionY - (deltaYparPosition * (totalPilotes - resultat.qualification));
                        positionY = positionStep1;
                        labelStep = "qualification";
                        textContent.push(labelPilote);
                        posContent.push( resultat.qualification );

                        break;

                    case 3:  // Step 3: Move up or down based on the course value
                        frameDivider = longStepDuration ; 
                        positionStep2 = basePositionY - (deltaYparPosition * (totalPilotes - resultat.qualification));
                        deltaQualifCourse = resultat.qualification - resultat.course
                        positionY = positionStep2 - (deltaYparPosition * deltaQualifCourse) * (frame / frameDivider);
                        labelStep = "course";
                        textContent.push(labelPilote);
                        posContent.push(  resultat.course );

                        break;

                    case 4:  // hold positions
                        frameDivider = shortStepDuration; 
                        positionStep3 = basePositionY - (deltaYparPosition * (totalPilotes - resultat.course));
                        positionY = positionStep3;
                        labelStep = "course";
                        textContent.push(labelPilote);
                        posContent.push( resultat.course );
                        scoreContent.push(resultat.score);

                        break;

                    case 5:  // Step 4: End of animation with a slight movement up and down
                    
                    frameDivider = longStepDuration;

                        // For the last step (Step 4), change color based on resultat.course
                        if (resultat.course == 1) {
                            bgColor = 'yellow';
                            textColor = 'black';
                        } else if (resultat.course == 2){
                            bgColor = 'grey';
                            textColor = 'white';
                        } else if (resultat.course == 3){
                            bgColor = 'brown';
                            textColor = 'white';
                        } else {
                            bgColor = 'black';
                            textColor = 'white';
                        }

                        // Calculate the vertical position based on the movement step
                        var basePositionStep3 = basePositionY - (deltaYparPosition * (totalPilotes - resultat.course));
                        var positionOffset = Math.sin((movementStep / totalSteps) * Math.PI * 2) * movementRange; 
                        positionY = basePositionStep3 + positionOffset;

                        labelStep = "Fin";
                        textContent.push( labelPilote + ' q: ' + resultat.qualification);
                        posContent.push( resultat.course );
                        scoreContent.push(resultat.score);

                        mtContent = resultat.mt
                        dotdContent = resultat.dotd

                        break;

                    case 6: // hold positions 

                        // For the last step (Step 4), change color based on resultat.course
                        if (resultat.course == 1) {
                            bgColor = 'yellow';
                            textColor = 'black';
                        } else if (resultat.course == 2){
                            bgColor = 'grey';
                            textColor = 'white';
                        } else if (resultat.course == 3){
                            bgColor = 'brown';
                            textColor = 'white';
                        } else {
                            bgColor = 'black';
                            textColor = 'white';
                        }

                        frameDivider = shortStepDuration; 
                        positionStep3 = basePositionY - (deltaYparPosition * (totalPilotes - resultat.course));
                        positionY = positionStep3;
                        labelStep = "Fin";
                        textContent.push( labelPilote + ' q: ' + resultat.qualification);
                        posContent.push( resultat.course );
                        scoreContent.push(resultat.score);

                        mtContent = resultat.mt
                        dotdContent = resultat.dotd


                        break;
                }

                const imgX = widthPosition + margeX + 5;
                const imgY = positionY - 10;

                // Draw the step indicator text inside the canvas
                ctx.fillStyle = "grey";
                ctx.fillRect(5, 5, canvas.width - 10, 30);

                ctx.fillStyle = "white";
                ctx.font = "24px F1regular";
                //var text = `Step ${step + 1} of ${animationSteps} ${labelStep}`;
                var text = labelStep;
                var textWidth = ctx.measureText(text).width;
                var x = (canvas.width - textWidth) / 2;-
                ctx.fillText(text, x, 30);

                // Draw the footer of the canvas with infos
                ctx.fillStyle = "grey";
                ctx.fillRect(5, canvas.height - 35, canvas.width - 10, 30);
                ctx.fillStyle = "white";
                ctx.font = "42px";
                text = infosEventValue;
                textWidth = ctx.measureText(text).width;
                x = (canvas.width - textWidth) / 2;

                ctx.fillText(text, x, canvas.height - 12);

                // draw position pilote 
                var fontSize = 40;
              //  var fontFamily = '';
                ctx.font = fontSize + 'px ' ;
                ctx.fillStyle = bgColor;

                drawRoundedRect(ctx, margeX, positionY - 10, widthPosition, hauteurEquipeImage, borderRadius);
            
                text = posContent[index];
                textWidth = ctx.measureText(text).width;
                var centerX = margeX + (widthPosition - textWidth) / 2;
                ctx.fillStyle = textColor;
                ctx.fillText(text, centerX, positionY + 10, widthPosition, hauteurEquipeImage);

                // draw score pilote 
                if (scoreContent[index] >= 0) {                    
                    var fontSize = 22;
                   // var fontFamily = 'Arial';
                    ctx.font = fontSize + 'px ';
                    ctx.fillStyle = bgColor;

                    drawRoundedRect(ctx, canvas.width - widthPosition - margeX, positionY - 10, widthPosition, hauteurEquipeImage, borderRadius);

                    text = scoreContent[index];
                    textWidth = ctx.measureText(text).width;
                    var centerX = canvas.width - widthPosition - margeX + (widthPosition - textWidth) / 2; // Adjust x-coordinate
                    ctx.fillStyle = textColor;
                    ctx.fillText(text, centerX, positionY + 10);
                }
                // Draw image equipe

                // Save the current canvas state before clipping the image
                ctx.save();

                // Create a path for the rounded rectangle and clip the image inside it
                drawRoundedRect(ctx, imgX, imgY, imgWidth, imgHeight, borderRadius);
                ctx.clip();

                // Draw the image inside the clipped path
                ctx.drawImage(imageObjects[index].image, imgX, imgY, imgWidth, imgHeight);
                ctx.restore();

                // draw label pilote
                ctx.fillStyle = "white";
                ctx.fillText( textContent[index], 160, positionY + 10 );

                if (mtContent == true) {
                    ctx.drawImage(imageMT, canvas.width - 28, positionY - 10, sizeMtDotd, sizeMtDotd); // Draw imageMT on the canvas at (10, 10) with width 50 and height 50
                }

                if (dotdContent == true) {
                    ctx.drawImage(imageDOTD, canvas.width - 28, positionY - 10, sizeMtDotd, sizeMtDotd); // Draw imageMT on the canvas at (10, 10) with width 50 and height 50
                }
            
            });
        }
        function animationLoop() {
           
            const easedProgress = easeInOutCubic(currentFrame / frameDivider);
            drawAnimation(currentStep, currentFrame, easedProgress);

            if (capturer) {
                capturer.capture(canvas);
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
                quality: 80,
                framerate: 60,
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
    //    console.log("call depuis bouton reload");
        const canvas = this.myCanvasTarget;
        const ctx = canvas.getContext('2d');

        const infosEvent = document.getElementById("infos-event");
        const infosEventValue = infosEvent.textContent;        

        const resultats = JSON.parse(this.element.dataset.animationResultatsValue);
        this.startAnimation(resultats, canvas, ctx, infosEventValue);

    }

}

