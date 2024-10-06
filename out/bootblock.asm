
out/bootblock.o:     file format elf32-i386


Disassembly of section .text:

00007c00 <start>:
    7c00:	fa                   	cli
    7c01:	31 c0                	xor    %eax,%eax
    7c03:	8e d8                	mov    %eax,%ds
    7c05:	8e c0                	mov    %eax,%es
    7c07:	8e d0                	mov    %eax,%ss

00007c09 <seta20.1>:
    7c09:	e4 64                	in     $0x64,%al
    7c0b:	a8 02                	test   $0x2,%al
    7c0d:	75 fa                	jne    7c09 <seta20.1>
    7c0f:	b0 d1                	mov    $0xd1,%al
    7c11:	e6 64                	out    %al,$0x64

00007c13 <seta20.2>:
    7c13:	e4 64                	in     $0x64,%al
    7c15:	a8 02                	test   $0x2,%al
    7c17:	75 fa                	jne    7c13 <seta20.2>
    7c19:	b0 df                	mov    $0xdf,%al
    7c1b:	e6 60                	out    %al,$0x60
    7c1d:	0f 01 16             	lgdtl  (%esi)
    7c20:	78 7c                	js     7c9e <readsect+0x12>
    7c22:	0f 20 c0             	mov    %cr0,%eax
    7c25:	66 83 c8 01          	or     $0x1,%ax
    7c29:	0f 22 c0             	mov    %eax,%cr0
    7c2c:	ea                   	.byte 0xea
    7c2d:	31 7c 08 00          	xor    %edi,0x0(%eax,%ecx,1)

00007c31 <start32>:
    7c31:	66 b8 10 00          	mov    $0x10,%ax
    7c35:	8e d8                	mov    %eax,%ds
    7c37:	8e c0                	mov    %eax,%es
    7c39:	8e d0                	mov    %eax,%ss
    7c3b:	66 b8 00 00          	mov    $0x0,%ax
    7c3f:	8e e0                	mov    %eax,%fs
    7c41:	8e e8                	mov    %eax,%gs
    7c43:	bc 00 7c 00 00       	mov    $0x7c00,%esp
    7c48:	e8 e4 00 00 00       	call   7d31 <bootmain>
    7c4d:	66 b8 00 8a          	mov    $0x8a00,%ax
    7c51:	66 89 c2             	mov    %ax,%dx
    7c54:	66 ef                	out    %ax,(%dx)
    7c56:	66 b8 e0 8a          	mov    $0x8ae0,%ax
    7c5a:	66 ef                	out    %ax,(%dx)

00007c5c <spin>:
    7c5c:	eb fe                	jmp    7c5c <spin>
    7c5e:	66 90                	xchg   %ax,%ax

00007c60 <gdt>:
	...
    7c68:	ff                   	(bad)
    7c69:	ff 00                	incl   (%eax)
    7c6b:	00 00                	add    %al,(%eax)
    7c6d:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7c74:	00                   	.byte 0x0
    7c75:	92                   	xchg   %eax,%edx
    7c76:	cf                   	iret
	...

00007c78 <gdtdesc>:
    7c78:	17                   	pop    %ss
    7c79:	00 60 7c             	add    %ah,0x7c(%eax)
	...

00007c7e <waitdisk>:
    7c7e:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7c83:	ec                   	in     (%dx),%al
    7c84:	83 e0 c0             	and    $0xffffffc0,%eax
    7c87:	3c 40                	cmp    $0x40,%al
    7c89:	75 f8                	jne    7c83 <waitdisk+0x5>
    7c8b:	c3                   	ret

00007c8c <readsect>:
    7c8c:	57                   	push   %edi
    7c8d:	53                   	push   %ebx
    7c8e:	8b 5c 24 10          	mov    0x10(%esp),%ebx
    7c92:	e8 e7 ff ff ff       	call   7c7e <waitdisk>
    7c97:	b8 01 00 00 00       	mov    $0x1,%eax
    7c9c:	ba f2 01 00 00       	mov    $0x1f2,%edx
    7ca1:	ee                   	out    %al,(%dx)
    7ca2:	ba f3 01 00 00       	mov    $0x1f3,%edx
    7ca7:	89 d8                	mov    %ebx,%eax
    7ca9:	ee                   	out    %al,(%dx)
    7caa:	89 d8                	mov    %ebx,%eax
    7cac:	c1 e8 08             	shr    $0x8,%eax
    7caf:	ba f4 01 00 00       	mov    $0x1f4,%edx
    7cb4:	ee                   	out    %al,(%dx)
    7cb5:	89 d8                	mov    %ebx,%eax
    7cb7:	c1 e8 10             	shr    $0x10,%eax
    7cba:	ba f5 01 00 00       	mov    $0x1f5,%edx
    7cbf:	ee                   	out    %al,(%dx)
    7cc0:	89 d8                	mov    %ebx,%eax
    7cc2:	c1 e8 18             	shr    $0x18,%eax
    7cc5:	83 c8 e0             	or     $0xffffffe0,%eax
    7cc8:	ba f6 01 00 00       	mov    $0x1f6,%edx
    7ccd:	ee                   	out    %al,(%dx)
    7cce:	b8 20 00 00 00       	mov    $0x20,%eax
    7cd3:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7cd8:	ee                   	out    %al,(%dx)
    7cd9:	e8 a0 ff ff ff       	call   7c7e <waitdisk>
    7cde:	8b 7c 24 0c          	mov    0xc(%esp),%edi
    7ce2:	b9 80 00 00 00       	mov    $0x80,%ecx
    7ce7:	ba f0 01 00 00       	mov    $0x1f0,%edx
    7cec:	fc                   	cld
    7ced:	f3 6d                	rep insl (%dx),%es:(%edi)
    7cef:	5b                   	pop    %ebx
    7cf0:	5f                   	pop    %edi
    7cf1:	c3                   	ret

00007cf2 <readseg>:
    7cf2:	57                   	push   %edi
    7cf3:	56                   	push   %esi
    7cf4:	53                   	push   %ebx
    7cf5:	8b 5c 24 10          	mov    0x10(%esp),%ebx
    7cf9:	8b 74 24 18          	mov    0x18(%esp),%esi
    7cfd:	89 df                	mov    %ebx,%edi
    7cff:	03 7c 24 14          	add    0x14(%esp),%edi
    7d03:	89 f0                	mov    %esi,%eax
    7d05:	25 ff 01 00 00       	and    $0x1ff,%eax
    7d0a:	29 c3                	sub    %eax,%ebx
    7d0c:	c1 ee 09             	shr    $0x9,%esi
    7d0f:	83 c6 01             	add    $0x1,%esi
    7d12:	39 fb                	cmp    %edi,%ebx
    7d14:	73 17                	jae    7d2d <readseg+0x3b>
    7d16:	56                   	push   %esi
    7d17:	53                   	push   %ebx
    7d18:	e8 6f ff ff ff       	call   7c8c <readsect>
    7d1d:	81 c3 00 02 00 00    	add    $0x200,%ebx
    7d23:	83 c6 01             	add    $0x1,%esi
    7d26:	83 c4 08             	add    $0x8,%esp
    7d29:	39 fb                	cmp    %edi,%ebx
    7d2b:	72 e9                	jb     7d16 <readseg+0x24>
    7d2d:	5b                   	pop    %ebx
    7d2e:	5e                   	pop    %esi
    7d2f:	5f                   	pop    %edi
    7d30:	c3                   	ret

00007d31 <bootmain>:
    7d31:	57                   	push   %edi
    7d32:	56                   	push   %esi
    7d33:	53                   	push   %ebx
    7d34:	6a 00                	push   $0x0
    7d36:	68 00 20 00 00       	push   $0x2000
    7d3b:	68 00 00 01 00       	push   $0x10000
    7d40:	e8 ad ff ff ff       	call   7cf2 <readseg>
    7d45:	83 c4 0c             	add    $0xc,%esp
    7d48:	b8 00 00 01 00       	mov    $0x10000,%eax
    7d4d:	eb 0a                	jmp    7d59 <bootmain+0x28>
    7d4f:	83 c0 04             	add    $0x4,%eax
    7d52:	3d 00 20 01 00       	cmp    $0x12000,%eax
    7d57:	74 2f                	je     7d88 <bootmain+0x57>
    7d59:	89 c3                	mov    %eax,%ebx
    7d5b:	81 38 02 b0 ad 1b    	cmpl   $0x1badb002,(%eax)
    7d61:	75 ec                	jne    7d4f <bootmain+0x1e>
    7d63:	8b 50 08             	mov    0x8(%eax),%edx
    7d66:	03 50 04             	add    0x4(%eax),%edx
    7d69:	81 fa fe 4f 52 e4    	cmp    $0xe4524ffe,%edx
    7d6f:	75 de                	jne    7d4f <bootmain+0x1e>
    7d71:	f6 40 06 01          	testb  $0x1,0x6(%eax)
    7d75:	74 11                	je     7d88 <bootmain+0x57>
    7d77:	8b 50 10             	mov    0x10(%eax),%edx
    7d7a:	8b 48 0c             	mov    0xc(%eax),%ecx
    7d7d:	39 d1                	cmp    %edx,%ecx
    7d7f:	72 07                	jb     7d88 <bootmain+0x57>
    7d81:	8b 70 14             	mov    0x14(%eax),%esi
    7d84:	39 d6                	cmp    %edx,%esi
    7d86:	73 04                	jae    7d8c <bootmain+0x5b>
    7d88:	5b                   	pop    %ebx
    7d89:	5e                   	pop    %esi
    7d8a:	5f                   	pop    %edi
    7d8b:	c3                   	ret
    7d8c:	8d 84 02 00 00 ff ff 	lea    -0x10000(%edx,%eax,1),%eax
    7d93:	29 c8                	sub    %ecx,%eax
    7d95:	50                   	push   %eax
    7d96:	29 d6                	sub    %edx,%esi
    7d98:	56                   	push   %esi
    7d99:	52                   	push   %edx
    7d9a:	e8 53 ff ff ff       	call   7cf2 <readseg>
    7d9f:	8b 4b 18             	mov    0x18(%ebx),%ecx
    7da2:	8b 43 14             	mov    0x14(%ebx),%eax
    7da5:	83 c4 0c             	add    $0xc,%esp
    7da8:	39 c8                	cmp    %ecx,%eax
    7daa:	73 0c                	jae    7db8 <bootmain+0x87>
    7dac:	29 c1                	sub    %eax,%ecx
    7dae:	89 c7                	mov    %eax,%edi
    7db0:	b8 00 00 00 00       	mov    $0x0,%eax
    7db5:	fc                   	cld
    7db6:	f3 aa                	rep stos %al,%es:(%edi)
    7db8:	ff 53 1c             	call   *0x1c(%ebx)
    7dbb:	eb cb                	jmp    7d88 <bootmain+0x57>
