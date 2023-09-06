import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["myCanvas"];

    capturer;

    connect() {
     
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

    startAnimation(resultats, canvas, ctx, infosEventValue, infosEventPrecedentValue) {

        //   console.log(resultats);
           
           var currentStep = 0;
           var currentFrame = 0;
   
           const animationSteps = 7;
   
           var frameDivider = 80;
           const longStepDuration = 80;
           const shortStepDuration = 40; 
           
           var capturer = this.capturer; // Assign capturer from the controller instance
   
           var totalPilotes = 10;
           var hauteurEquipeImage = 20;
           var widthPosition = 35;
   
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
   
           var deltaYparPosition = 22;
   
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
                 //  console.log('set background')
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
      
               resultats.forEach(function(resultat, index) {
                   
               //    console.log(resultats);
                   var labelEquipe = resultat.equipe_nom;
   
                   const image = new Image();
                   image.crossOrigin = 'anonymous';
                   image.src = resultat.banniere_url;
                   
                   imageObjects.push({
                       image: image,
                       positionY: 0
                   });
   
                  // console.log(imageObjects);
   
                   switch (step) {
                       case 0:  // Step 1: Position at the bottom of the canvas
                           frameDivider = shortStepDuration; 
                           bgColor = 'black';
                           textColor = 'white';
                           positionY = basePositionY;
                           labelStep = "début";
                           textContent.push(labelEquipe);
                           scoreContent.push(resultat.score);
                           break;
   
                       case 1:   // Step 2: Move up based on the rank_precedent value + 50
                           frameDivider = longStepDuration; 
                           positionY = basePositionY - ((deltaYparPosition * (totalPilotes - resultat.rank_precedent)) * (frame / frameDivider));
                           labelStep = infosEventPrecedentValue;
                           textContent.push( labelEquipe );
                           posContent.push( resultat.rank_precedent );
                           scoreContent.push(resultat.score);
                           break;
                   
                       case 2: // hold positions
                           frameDivider = shortStepDuration; 
                           positionStep1 = basePositionY - (deltaYparPosition * (totalPilotes - resultat.rank_precedent));
                           positionY = positionStep1;
                           labelStep = infosEventPrecedentValue;
                           textContent.push(labelEquipe);
                           posContent.push( resultat.rank_precedent );
                           scoreContent.push(resultat.score);
                           break;
   
                       case 3:  // Step 3: Move up or down based on the rank_courant value
                           frameDivider = longStepDuration ; 
                           positionStep2 = basePositionY - (deltaYparPosition * (totalPilotes - resultat.rank_precedent));
                           deltaQualifCourse = resultat.rank_precedent - resultat.rank_courant
                           positionY = positionStep2 - (deltaYparPosition * deltaQualifCourse) * (frame / frameDivider);
                           labelStep = infosEventValue;
                           textContent.push(labelEquipe);
                           posContent.push(  resultat.rank_courant );
                           scoreContent.push(resultat.score);
                           break;
   
                       case 4:  // hold positions
                           frameDivider = shortStepDuration; 
                           positionStep3 = basePositionY - (deltaYparPosition * (totalPilotes - resultat.rank_courant));
                           positionY = positionStep3;
                           labelStep = infosEventValue;
                           textContent.push(labelEquipe);
                           posContent.push( resultat.rank_courant );
                           scoreContent.push(resultat.score);
                           break;
   
                       case 5:  // Step 4: End of animation with a slight movement up and down
                       
                       frameDivider = longStepDuration;
   
                           // For the last step (Step 4), change color based on resultat.course
                           if (resultat.rank_courant == 1) {
                               bgColor = 'yellow';
                               textColor = 'black';
                           } else if (resultat.rank_courant == 2){
                               bgColor = 'grey';
                               textColor = 'white';
                           } else if (resultat.rank_courant == 3){
                               bgColor = 'brown';
                               textColor = 'white';
                           } else {
                               bgColor = 'black';
                               textColor = 'white';
                           }
   
                           // Calculate the vertical position based on the movement step
                           var basePositionStep3 = basePositionY - (deltaYparPosition * (totalPilotes - resultat.rank_courant));
                           var positionOffset = Math.sin((movementStep / totalSteps) * Math.PI * 2) * movementRange; 
                           positionY = basePositionStep3 + positionOffset;
   
                           labelStep = "Fin";
                           textContent.push( labelEquipe);
                           posContent.push( resultat.rank_courant );
                           scoreContent.push(resultat.score);
      
                           break;
   
                       case 6: // hold positions 
   
                           // For the last step (Step 4), change color based on resultat.course
                           if (resultat.rank_courant == 1) {
                               bgColor = 'yellow';
                               textColor = 'black';
                           } else if (resultat.rank_courant == 2){
                               bgColor = 'grey';
                               textColor = 'white';
                           } else if (resultat.rank_courant == 3){
                               bgColor = 'brown';
                               textColor = 'white';
                           } else {
                               bgColor = 'black';
                               textColor = 'white';
                           }
   
                           frameDivider = shortStepDuration; 
                           positionStep3 = basePositionY - (deltaYparPosition * (totalPilotes - resultat.rank_courant));
                           positionY = positionStep3;
                           labelStep = "Fin";
                           textContent.push( labelEquipe);
                           posContent.push( resultat.rank_courant );
                           scoreContent.push(resultat.score);
      
                           break;
                   }
   
                   const imgX = widthPosition + margeX + 5;
                   const imgY = positionY - 10;
   
                   // Draw the step indicator text inside the canvas
                   ctx.fillStyle = "grey";
                   ctx.fillRect(5, 5, canvas.width - 10, 30);
   
                   ctx.fillStyle = "white";
                   ctx.font = "18px F1regular";
                   //var text = `Step ${step + 1} of ${animationSteps} ${labelStep}`;
                   var text = labelStep;
                   var textWidth = ctx.measureText(text).width;
                   var x = (canvas.width - textWidth) / 2;
                   ctx.fillText(text, x, 30);
   
                   // Draw the footer of the canvas with infos
                   ctx.fillStyle = "grey";
                   ctx.fillRect(5, canvas.height - 35, canvas.width - 10, 30);
                   ctx.fillStyle = "white";
                  // ctx.font = "42px";
                   text = infosEventValue;
                   textWidth = ctx.measureText(text).width;
                   x = (canvas.width - textWidth) / 2;
   
                   ctx.fillText(text, x, canvas.height - 12);
   
                   // draw position pilote 
                   var fontSize = 10;
                   ctx.font = fontSize + 'px ' ;
                   ctx.fillStyle = bgColor;
   
                   drawRoundedRect(ctx, margeX, positionY - 10, widthPosition, hauteurEquipeImage, borderRadius);
               
                   text = posContent[index];
                   textWidth = ctx.measureText(text).width;
                   var centerX = margeX + (widthPosition - textWidth) / 2;
                   ctx.fillStyle = textColor;
                   ctx.fillText(text, centerX, positionY + 6, widthPosition, hauteurEquipeImage);
   
                   // draw score pilote 
                   if (scoreContent[index] >= 0) {                    
                       var fontSize = 10;
                      // var fontFamily = 'Arial';
                       ctx.font = fontSize + 'px ';
                       ctx.fillStyle = bgColor;
   
                       drawRoundedRect(ctx, canvas.width - widthPosition - margeX, positionY - 10, widthPosition, hauteurEquipeImage, borderRadius);
   
                       text = scoreContent[index];
                       textWidth = ctx.measureText(text).width;
                       var centerX = canvas.width - widthPosition - margeX + (widthPosition - textWidth) / 2; // Adjust x-coordinate
                       ctx.fillStyle = textColor;
                       ctx.fillText(text, centerX, positionY + 6);
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
                   
                   // Maximum length for the text content
                   const maxLength = 10; // Adjust the maximum length as needed
   
                   // Get the original text content
                   const originalText = textContent[index];
   
                   // Check if the text length exceeds the maximum length
                   if (originalText.length > maxLength) {
                   // Truncate the text and add ellipsis
                   const truncatedText = originalText.substring(0, maxLength) + "...";
                   ctx.fillText(truncatedText, 110, positionY + 6);
                   } else {
                   ctx.fillText(originalText, 110, positionY + 6);
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
                   name: "video_if1",
                   allowTaint: false,
                   useCORS: true
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
           canvas.allowTaint = false;
           canvas.useCORS = true;
           const ctx = canvas.getContext('2d');
   
           const infosEvent = document.getElementById("infos-event");
           const infosEventValue = infosEvent.textContent;        

           const infosEventPrecedent = document.getElementById("infos-event-precedent");
           const infosEventPrecedentValue = infosEventPrecedent.textContent;        
   
           const resultats = JSON.parse(this.element.dataset.animationClassEquipesResultatsValue);

           this.startAnimation(resultats, canvas, ctx, infosEventValue, infosEventPrecedentValue);
   
    }
   

}