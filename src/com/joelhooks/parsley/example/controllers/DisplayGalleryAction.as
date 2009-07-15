/*
	Inversion of Control/Dependency Injection Using Parsley
	Image Gallery
	
	Any portion of this demonstration may be reused for any purpose where not 
	licensed by another party restricting such use. Please leave the credits intact.
	
	Joel Hooks
	http://joelhooks.com
	joelhooks@gmail.com 
*/
package com.joelhooks.parsley.example.controllers
{
	import com.joelhooks.parsley.example.events.GalleryImageEvent;
	import com.joelhooks.parsley.example.models.presentation.IGalleryPresentationModel;
	import com.joelhooks.parsley.example.models.vo.Gallery;
	import com.joelhooks.parsley.example.models.vo.GalleryImage;
	
	import flash.events.EventDispatcher;

	public class DisplayGalleryAction extends EventDispatcher
	{
		[Autowire]
		public var galleryPresentationModel:IGalleryPresentationModel;
		
		public function DisplayGalleryAction()
		{
		}
		
		[Mediate(event="galleryLoaded", properties="gallery")]
		public function handleGalleryLoaded(gallery:Gallery):void
		{
			this.galleryPresentationModel.gallery = gallery

		}
	}
}