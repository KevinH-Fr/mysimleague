import { Controller } from "@hotwired/stimulus";
import * as THREE from "three";
import { GLTFLoader } from 'https://ga.jspm.io/npm:three@0.158.0/examples/jsm/loaders/GLTFLoader.js?module';
import { OrbitControls } from 'https://ga.jspm.io/npm:three@0.158.0/examples/jsm/controls/OrbitControls.js?module';

export default class extends Controller {
  connect() {
    this.scene = new THREE.Scene();
    this.camera = new THREE.PerspectiveCamera(
      75,
      window.innerWidth / window.innerHeight,
      0.1,
      1000
    );
    this.renderer = new THREE.WebGLRenderer();
    this.renderer.setSize(window.innerWidth, window.innerHeight);
    document.body.appendChild(this.renderer.domElement);
    this.scene.background = new THREE.Color(0xFFFFFF);

    this.pointLight = new THREE.PointLight(0xFFFFFF, 1, 10);
    this.pointLight.position.set(0, 4, 0);
    this.pointLight.decay = 2;
    this.pointLight.castShadow = true;

    this.pointLight2 = new THREE.PointLight(0xFFFFFF, 10, 10);
    this.pointLight2.position.set(-5, 4, 0);
    this.pointLight2.decay = 2;
    this.pointLight2.castShadow = true;


    this.lightHelper = new THREE.PointLightHelper(this.pointLight);
    this.gridHelper = new THREE.GridHelper(100, 100);

    const directionalLight = new THREE.DirectionalLight(0xffffff, 0.8);
    directionalLight.position.set(1, 1, 1);

    this.scene.add(
      this.lightHelper,
      this.pointLight,
      this.pointLight2,
      directionalLight
    );

    this.controls = new OrbitControls(this.camera, this.renderer.domElement);

    this.messageContainer = document.createElement('div');
    this.messageContainer.style.position = 'absolute';
    this.messageContainer.style.bottom = '60px';
    this.messageContainer.style.left = '20px';
    this.messageContainer.style.fontSize = '18px';
    
    // Set background color and other styles for the badge
    this.messageContainer.style.backgroundColor = 'blue'; // Change color as needed
    this.messageContainer.style.width = "90%"; // Change color as needed
    
    this.messageContainer.style.padding = '5px'; // Adjust padding as needed
    this.messageContainer.style.borderRadius = '5px'; // Add border radius for rounded corners
    
    // Set text color
    this.messageContainer.style.color = 'white'; // Change color as needed
    this.messageContainer.style.textAlign = 'center'; // Center the text horizontally

    // Set the text content of the badge
    this.messageContainer.textContent = 'Touche la F1 !';
    
    document.body.appendChild(this.messageContainer);
    

    this.raycaster = new THREE.Raycaster();
    this.mouse = new THREE.Vector2();

    window.addEventListener('click', (event) => this.onMouseClick(event), false);
    window.addEventListener('resize', () => this.onWindowResize(), false);

    this.loadModel('/assets/base_f1.glb');
    this.animate();
  }

  loadModel(modelPath) {
    const loader = new GLTFLoader();
    loader.load(modelPath, (gltf) => {
      gltf.scene.scale.set(1, 1, 1);

      // Store initial colors of all objects
      this.initialColors = new Map();
      gltf.scene.traverse((child) => {
        if (child.isMesh) {
          this.initialColors.set(child, child.material.color.clone());
        }
      });

      this.scene.add(gltf.scene);
      this.camera.position.set(0, 2, 5);
      this.camera.lookAt(0, 0, 0);
    }, undefined, (error) => {
      console.error("Error loading model:", error);
    });
  }

  onMouseClick(event) {
    this.mouse.x = (event.clientX / window.innerWidth) * 2 - 1;
    this.mouse.y = - (event.clientY / window.innerHeight) * 2 + 1;

    this.raycaster.setFromCamera(this.mouse, this.camera);

    const intersects = this.raycaster.intersectObjects(this.scene.children, true);

    // Reset colors of all objects to their initial values
    this.initialColors.forEach((initialColor, object) => {
      if (object.isMesh) {
        object.material.color.copy(initialColor);
      }
    });

    if (intersects.length > 0) {
      const clickedObject = intersects[0].object;

      console.log(clickedObject);

      if (clickedObject.isMesh) {
        // Change the color of the clicked object to red
        clickedObject.material.color.set(0xff0000);
        this.showMessage(`Tu as cliqué sur: ${clickedObject.name}!`);
        
      } else {
        this.showMessage(`You clicked on an object with no name!`);
      }
    }
  }

  onWindowResize() {
    this.camera.aspect = window.innerWidth / window.innerHeight;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(window.innerWidth, window.innerHeight);
  }

  showMessage(message) {
    this.messageContainer.innerText = message;
  }


  animate() {
    requestAnimationFrame(this.animate.bind(this));

    this.controls.update();
    this.renderer.render(this.scene, this.camera);
  }
  
}
