/*
	Inversion of Control/Dependency Injection Using Parsley
	Image Gallery
	
	Any portion of this demonstration may be reused for any purpose where not 
	licensed by another party restricting such use. Please leave the credits intact.
	
	Joel Hooks
	http://joelhooks.com
	joelhooks@gmail.com 
*/
package com.joelhooks.parsley.example.models.presentation
{
	import com.joelhooks.parsley.example.models.vo.Gallery;
	import com.joelhooks.parsley.example.models.vo.GalleryImage;
	
	[Bindable]
	public interface IGalleryPresentationModel
	{
		[Bindable( "galleryChanged" )]
		function get gallery():Gallery;
		function set gallery(v:Gallery):void;
		
		[Bindable( "selectedImageChanged" )]
		function get selectedImage():GalleryImage;
		function set selectedImage(v:GalleryImage):void;
	}
}